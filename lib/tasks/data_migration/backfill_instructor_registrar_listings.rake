# typed: strict
# frozen_string_literal: true

extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :data_migration do
  desc "Backfill the registrar listings for instructors associated with sections"
  task backfill_instructor_registrar_listings: :environment do
    Rails.logger = Logger.new($stdout)
    ActiveRecord::Base.logger = Rails.logger

    # Change to :debug for ActiveRecord SQL logs.
    Rails.logger.level = :info

    Searchkick.disable_callbacks

    Section.all.find_each do |section|
      Rails.logger.info("Section: #{section.id}, Section instructors: #{section.registrar_instructors}, Section instructor id: #{section.instructor_id}")
      if (section.registrar_instructors == ["No instructor"]) || (section.registrar_instructors == ["No instructors"]) || (section.registrar_instructors == ["The Staff"])
        Rails.logger.info("Section has no instructor")
        section.instructor = nil
        section.save!
      elsif section.instructor_id?
        begin
          instructor = T.must(section.instructor)
          instructor.registrar_listing = section.registrar_instructors
          instructor.save!
          Rails.logger.info("Updated instructor listing with section registrar listing")
        rescue ActiveRecord::RecordNotUnique
          Rails.logger.info("Unique key issue, finding and copying to other instructor")
          other_instructor = T.must(Instructor.find_by(registrar_listing: section.registrar_instructors))
          Rails.logger.info("Other instructor: #{other_instructor.id}")
          section.instructor = other_instructor
          other_instructor.first_names = T.must(instructor).first_names
          other_instructor.last_names = T.must(instructor).last_names
          other_instructor.save!
          section.save!
        end
      else
        Rails.logger.info("No instructor found, creating one")
        listing = section.registrar_instructors
        instructor = Instructor.find_or_create_by(registrar_listing: listing)
        section.instructor = instructor
        section.save
      end
    end

    orphaned_instructors = Instructor.all.where(registrar_listing: nil)
    Rails.logger.info("Orphaned instructors: #{orphaned_instructors.size}, deleting")
    orphaned_instructors.destroy_all

    Searchkick.enable_callbacks
  end
end
