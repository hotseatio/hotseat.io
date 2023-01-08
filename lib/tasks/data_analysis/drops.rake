# typed: strict
# frozen_string_literal: true

require "awesome_print"

# Add Sorbet support
# https://sorbet.org/docs/faq#does-sorbet-work-with-rake-and-rakefiles
extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_analysis do
  desc "Get the most dropped sections for the given term"
  task :drops, %i[term] => %i[environment] do |_, args|
    Rails.logger = Logger.new($stdout)

    term = T.must(Term.find_by(term: args[:term]))
    enrollment_start = term.start_time
    enrollment_end = term.end_of_week_two_time

    sections = Section.where(term:).where.not(enrollment_status: "Canceled")
    drop_counts = sections.map do |section|
      data = section.enrollment_data
                    .where(created_at: enrollment_start..enrollment_end)
                    .where.not(enrollment_capacity: 0)
                    .order(:created_at)

      enrollment_start_datum = data.first
      enrollment_end_datum = data.last

      if enrollment_start_datum.nil?
        Rails.logger.info("Skipping section, could not find any start data. Section: #{section.id}")
        next
      end
      if enrollment_end_datum.nil?
        Rails.logger.info("Skipping section, could not find any end data. Section: #{section.id}")
        next
      end

      drop_count = (enrollment_start_datum.enrollment_count + enrollment_start_datum.waitlist_count) - (enrollment_end_datum.enrollment_count + enrollment_end_datum.waitlist_count)
      {
        drop_count:,
        start_count: enrollment_start_datum.enrollment_count,
        start_count_waitlist: enrollment_start_datum.waitlist_count,
        start_time: enrollment_start_datum.created_at,
        end_count: enrollment_end_datum.enrollment_count,
        end_count_waitlist: enrollment_end_datum.waitlist_count,
        end_time: enrollment_end_datum.created_at,
        section: section.id,
        course: section.course_title,
        instructor: section.instructor&.full_label || section.registrar_instructor_label,
        url: "https://hotseat.io/courses/#{section.course_id}/instructors/#{section.instructor_id}",
      }
    end
    puts ap(drop_counts.compact.sort_by { |counts| counts[:drop_count] })
  end
end
