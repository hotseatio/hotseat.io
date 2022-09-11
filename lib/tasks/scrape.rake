# typed: strict
# frozen_string_literal: true

require 'scrapers/enrollment_appointment'
require 'scrapers/term_dates'
require 'scrapers/lambda_scraper'
require 'scrapers/summer_session_dates'

# Add Sorbet support
# https://sorbet.org/docs/faq#does-sorbet-work-with-rake-and-rakefiles
extend Rake::DSL # rubocop:disable Style/MixinUsage

# Source: https://registrar.ucla.edu/registration-classes/enrollment-appointments/enrollment-appointments
enrollment_appointments_map = T.let(
  {
    '2016' => 'lib/tasks/scrapedata/enrollment_appointments/2016.html',
    '2017' => 'lib/tasks/scrapedata/enrollment_appointments/2017.html',
    '2018' => 'lib/tasks/scrapedata/enrollment_appointments/2018.html',
    '2019' => 'lib/tasks/scrapedata/enrollment_appointments/2019.html',
    '2020' => 'lib/tasks/scrapedata/enrollment_appointments/2020.html',
    '2021' => 'lib/tasks/scrapedata/enrollment_appointments/2021.html',
    '2022' => 'lib/tasks/scrapedata/enrollment_appointments/2022.html',
    '2023' => 'lib/tasks/scrapedata/enrollment_appointments/2023.html',
  },
  T::Hash[String, String],
)

term_dates_map = T.let(
  {
    '1999' => 'lib/tasks/scrapedata/term_dates/academiccalendar1999-2000.pdf',
    '2000' => 'lib/tasks/scrapedata/term_dates/academiccalendar00-01.pdf',
    '2001' => 'lib/tasks/scrapedata/term_dates/academiccalendar01-02.pdf',
    '2002' => 'lib/tasks/scrapedata/term_dates/academiccalendar02-03.pdf',
    '2003' => 'lib/tasks/scrapedata/term_dates/academiccalendar03-04.pdf',
    '2004' => 'lib/tasks/scrapedata/term_dates/academiccalendar04-05.pdf',
    '2005' => 'lib/tasks/scrapedata/term_dates/academiccalendar05-06.pdf',
    '2006' => 'lib/tasks/scrapedata/term_dates/academiccalendar06-07.pdf',
    '2007' => 'lib/tasks/scrapedata/term_dates/academiccalendar07-08.pdf',
    '2008' => 'lib/tasks/scrapedata/term_dates/academiccalendar08-09.pdf',
    '2009' => 'lib/tasks/scrapedata/term_dates/academiccalendar09-10.pdf',
    '2010' => 'lib/tasks/scrapedata/term_dates/academiccalendar10-11.pdf',
    '2011' => 'lib/tasks/scrapedata/term_dates/academiccalendar11-12.pdf',
    '2012' => 'lib/tasks/scrapedata/term_dates/academiccalendar12-13.pdf',
    '2013' => 'lib/tasks/scrapedata/term_dates/academiccalendar13-14.pdf',
    '2014' => 'lib/tasks/scrapedata/term_dates/academiccalendar14-15.pdf',
    '2015' => 'lib/tasks/scrapedata/term_dates/academiccalendar15-16.pdf',
    '2016' => 'lib/tasks/scrapedata/term_dates/academiccalendar16-17.html',
    '2017' => 'lib/tasks/scrapedata/term_dates/academiccalendar17-18.html',
    '2018' => 'lib/tasks/scrapedata/term_dates/academiccalendar18-27.html',
    '2019' => 'lib/tasks/scrapedata/term_dates/academiccalendar18-27.html',
    '2020' => 'lib/tasks/scrapedata/term_dates/academiccalendar18-27.html',
    '2021' => 'lib/tasks/scrapedata/term_dates/academiccalendar18-27.html',
    '2022' => 'lib/tasks/scrapedata/term_dates/academiccalendar18-27.html',
    '2023' => 'lib/tasks/scrapedata/term_dates/academiccalendar18-27.html',
  },
  T::Hash[String, String],
)

summer_session_dates_map = T.let(
  {
    '2016' => 'lib/tasks/scrapedata/summer_session_dates/summer-calendar-2016-2017.html',
    '2017' => 'lib/tasks/scrapedata/summer_session_dates/summer-calendar-2016-2017.html',
    '2018' => 'lib/tasks/scrapedata/summer_session_dates/summer-calendar-2018.html',
    '2019' => 'lib/tasks/scrapedata/summer_session_dates/summer-calendar-2019-2020.html',
    '2020' => 'lib/tasks/scrapedata/summer_session_dates/summer-calendar-2019-2020.html',
    '2021' => 'lib/tasks/scrapedata/summer_session_dates/summer-calendar-2021.html',
  },
  T::Hash[String, String],
)

namespace :scrape do
  desc 'Scrape enrollment appointments'
  task :enrollment_appointments, %i[year] => %i[environment] do |_, args|
    Rails.logger = Logger.new($stdout)

    if args[:year].blank?
      enrollment_appointments_map.each do |year, year_url|
        Rails.logger.info "#{year}: fetching #{year_url}"
        EnrollmentAppointmentScraper.scrape(year_url)
      end
    else
      year = args[:year]
      year_url = enrollment_appointments_map[year]
      Rails.logger.info "#{year}: fetching #{year_url}"
      EnrollmentAppointmentScraper.scrape(T.must(year_url))
    end
  end

  desc 'Scrape term start and end dates'
  task :term_dates, %i[year] => %i[environment] do |_, args|
    Rails.logger = Logger.new($stdout)

    if args[:year].blank?
      term_dates_map.each do |year, year_url|
        Rails.logger.info "#{year}: fetching #{year_url}"
        TermDatesScraper.scrape(year_url)
      end
    else
      year = args[:year]
      year_url = term_dates_map[year]
      Rails.logger.info "#{year}: fetching #{year_url}"
      TermDatesScraper.scrape(T.must(year_url))
    end
  end

  desc 'Scrape summer session start dates'
  task :summer_session_dates, %i[year] => %i[environment] do |_, args|
    Rails.logger = Logger.new($stdout)

    if args[:year].blank?
      summer_session_dates_map.each do |year, year_url|
        Rails.logger.info "#{year}: fetching #{year_url}"
        SummerSessionDatesScraper.scrape(year_url, year)
      end
    else
      year = args[:year]
      year_url = T.must(summer_session_dates_map[year])
      Rails.logger.info "#{year}: fetching #{year_url}"
      SummerSessionDatesScraper.scrape(year_url, year)
    end
  end

  desc 'Scrape subject areas'
  task :subject_areas, %i[term] => %i[environment] do |_, args|
    Rails.logger = Logger.new($stdout)

    unless T.cast(Rails.env, ActiveSupport::EnvironmentInquirer).production?
      Rails.logger.error 'Can only run in production environment.'
      return
    end

    if args[:term].blank?
      Term
        .where('start_date < ?', Time.zone.now)
        # The subject area api goes back to 2016
        .where('start_date > ?', Time.zone.local(2016))
        .order_chronologically_asc.each do |term|
        Rails.logger.info "Invoking for #{term.readable}"
        LambdaScraper.invoke_for_term('fetch-subject-areas', term)

        # Wait for scrapers to finish
        sleep(3.minutes.in_seconds)
      end
    else
      term = Term.find_by(term: args[:term])
      if term.nil?
        Rails.logger.error "Unknown term: #{args[:term]}"
      else
        LambdaScraper.invoke_for_term('fetch-subject-areas', term)
      end
    end
  end

  desc 'Scrape courses'
  task :courses, %i[term] => %i[environment] do |_, args|
    Rails.logger = Logger.new($stdout)

    unless T.cast(Rails.env, ActiveSupport::EnvironmentInquirer).production?
      Rails.logger.error 'Can only run in production environment.'
      return
    end

    if args[:term].blank?
      Term
        .where('start_date < ?', Time.zone.now)
        .order_chronologically_asc.each do |term|
        Rails.logger.info "Invoking for #{term.readable}"
        LambdaScraper.invoke_for_term('trigger-courses', term)

        # Wait for scrapers to finish
        sleep(3.minutes.in_seconds)
      end
    else
      term = Term.find_by(term: args[:term])
      if term.nil?
        Rails.logger.error "Unknown term: #{args[:term]}"
      else
        LambdaScraper.invoke_for_term('trigger-courses', term)
      end
    end
  end

  desc 'Scrape sections'
  task :sections, %i[term] => %i[environment] do |_, args|
    Rails.logger = Logger.new($stdout)

    unless T.cast(Rails.env, ActiveSupport::EnvironmentInquirer).production?
      Rails.logger.error 'Can only run in production environment.'
      return
    end

    if args[:term].blank?
      Term
        .where('start_date < ?', Time.zone.now)
        .order_chronologically_asc.each do |term|
        Rails.logger.info "Invoking for #{term.readable}"
        LambdaScraper.invoke_for_term('trigger-sections', term)

        # Wait for scrapers to finish
        sleep(3.minutes.in_seconds)
      end
    else
      term = Term.find_by(term: args[:term])
      if term.nil?
        Rails.logger.error "Unknown term: #{args[:term]}"
      else
        LambdaScraper.invoke_for_term('trigger-sections', term)
      end
    end
  end

  desc 'Scrape textbooks'
  task :textbooks, %i[term] => %i[environment] do |_, args|
    Rails.logger = Logger.new($stdout)

    unless T.cast(Rails.env, ActiveSupport::EnvironmentInquirer).production?
      Rails.logger.error 'Can only run in production environment.'
      return
    end

    term = Term.find_by(term: args[:term])
    term = Term.current if term.nil?
    Rails.logger.info "Invoking for #{term.readable}"
    LambdaScraper.invoke_for_term('trigger-textbooks', term)
  end

  desc 'Scrape instructors'
  task :instructors, %i[term] => %i[environment] do |_, args|
    Rails.logger = Logger.new($stdout)

    unless T.cast(Rails.env, ActiveSupport::EnvironmentInquirer).production?
      Rails.logger.error 'Can only run in production environment.'
      return
    end

    if args[:term].blank?
      Term
        .where('start_date < ?', Time.zone.now)
        # The subject area api goes back to 2013
        .where('start_date > ?', Time.zone.local(2013))
        .order_chronologically_asc.each do |term|
        Rails.logger.info "Invoking for #{term.readable}"
        LambdaScraper.invoke_for_term('trigger-instructors', term)

        # Wait for scrapers to finish
        sleep(3.minutes.in_seconds)
      end
    else
      term = Term.find_by(term: args[:term])
      if term.nil?
        Rails.logger.error "Unknown term: #{args[:term]}"
      else
        LambdaScraper.invoke_for_term('trigger-instructors', term)
      end
    end
  end

  desc 'Scrape course descriptions'
  task course_descriptions: :environment do
    Rails.logger = Logger.new($stdout)

    unless T.cast(Rails.env, ActiveSupport::EnvironmentInquirer).production?
      Rails.logger.error 'Can only run in production environment.'
      return
    end

    LambdaScraper.invoke_function('trigger-course-descriptions', {})
  end
end
