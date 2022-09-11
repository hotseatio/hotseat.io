# typed: strict
# frozen_string_literal: true

# Add Sorbet support
# https://sorbet.org/docs/faq#does-sorbet-work-with-rake-and-rakefiles
extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :populate do
  desc 'Populate instructors for term'
  task :instructors, %i[term] => %i[environment] do |_, args|
    Rails.logger = Logger.new($stdout)

    term = Term.find_by(term: args[:term])
    if term.nil?
      Rails.logger.error "Unknown term: #{args[:term]}"
      return
    end
    Rails.logger.info("Using term #{term.readable}")

    SubjectArea.all.find_each do |subject_area|
      Rails.logger.info("Subject Area: #{subject_area.name}")
      sections = Section.joins(:instructor, :course).where('courses.subject_area_id': subject_area)
      Section.joins(:course).where(term:, 'courses.subject_area_id': subject_area).find_each do |section|
        course = section.course
        Rails.logger.info("Handling #{course.short_title} #{section.title}")

        registrar_instructors = section.registrar_instructors
        if registrar_instructors.empty? || registrar_instructors.first == 'No instructors'
          Rails.logger.info('No instructor for section, skipping')
          next
        end

        section_with_same_instructor = sections.find_by(registrar_instructors:)

        if section_with_same_instructor.nil?
          Rails.logger.info("Couldn't find previous section with same instructor, skipping")
          next
        end

        Rails.logger.info("Found a match: #{section_with_same_instructor.course_title} #{section_with_same_instructor.title}")
        Rails.logger.info("Matching registrar instructor: #{registrar_instructors}")
        matched_instructor = T.must(section_with_same_instructor.instructor)
        Rails.logger.info("This corresponds to instructor: #{matched_instructor.full_label}")
        section.instructor = matched_instructor
        section.save!
        Rails.logger.info('Updated section instructor!')
      end
    end
  end
end
