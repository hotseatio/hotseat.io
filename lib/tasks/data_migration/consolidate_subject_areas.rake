# typed: strict
# frozen_string_literal: true

extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_migration do
  desc "Consolidate subject areas due to a scraping error ('MATH' instead of 'MATH    ')"
  task consolidate_subject_areas: :environment do
    Rails.logger = Logger.new($stdout)
    ActiveRecord::Base.logger = Rails.logger

    # Change to :debug for ActiveRecord SQL logs.
    Rails.logger.level = :info

    ActiveRecord::Base.transaction do
      bad_subject_areas = SubjectArea.where("code LIKE '% '").order(:code)
      bad_subject_areas.each do |bad_subject_area|
        good_code = bad_subject_area.code.strip
        good_subject_area = T.must(SubjectArea.find_by(code: good_code))

        Rails.logger.info "#{good_code} (#{bad_subject_area.id}): found good subject area #{good_subject_area.id}"

        bad_courses = bad_subject_area.courses
        bad_courses.each do |bad_course|
          good_course = good_subject_area.courses.find_by(
            title: bad_course.title,
            number: bad_course.number,
          )

          if good_course.nil?
            Rails.logger.info "#{bad_course.short_title} (#{bad_course.id}): did not find good course; transferring to good subject area"
            good_subject_area.courses << bad_course

          else
            Rails.logger.info "#{bad_course.short_title} (#{bad_course.id}): found good course #{good_course.id}"

            # Update courses_terms
            ActiveRecord::Base.connection.execute <<-SQL.squish
              UPDATE courses_terms orig
              SET course_id = #{good_course.id}
              WHERE course_id = #{bad_course.id} AND
                    NOT EXISTS (SELECT 1
                                FROM courses_terms ct
                                WHERE ct.course_id = #{good_course.id} AND ct.term_id = orig.term_id)
            SQL
            # Delete duplicates in courses_terms
            ActiveRecord::Base.connection.execute <<-SQL.squish
              DELETE FROM courses_terms
              WHERE course_id = #{bad_course.id}
            SQL

            # Update course_section_indices
            ActiveRecord::Base.connection.execute <<-SQL.squish
              UPDATE course_section_indices orig
              SET course_id = #{good_course.id}
              WHERE course_id = #{bad_course.id} AND
                    NOT EXISTS (SELECT 1
                                FROM course_section_indices csi
                                WHERE csi.course_id = #{good_course.id} AND csi.term_id = orig.term_id)
            SQL
            # Delete duplicates in course_section_indices
            ActiveRecord::Base.connection.execute <<-SQL.squish
              DELETE FROM course_section_indices
              WHERE course_id = #{bad_course.id}
            SQL

            # Move sections
            good_course.sections << T.unsafe(bad_course.sections)

            # Remove bad course
            bad_course.delete
          end
        end

        bad_subject_area.delete
      end
    end
  end
end
