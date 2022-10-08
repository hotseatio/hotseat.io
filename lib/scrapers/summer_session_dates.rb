# typed: strict
# frozen_string_literal: true

module SummerSessionDatesScraper
  extend T::Sig

  sig { params(file: String, year: String).void }
  def self.scrape(file, year)
    # Read file
    raw_input = Rails.root.join(file).read
    doc = Nokogiri.HTML(raw_input)

    if year < '2021'
      scrape_old_format(doc)
    else
      scrape_new_format(doc)
    end
  end

  sig { params(doc: T.untyped).void }
  def self.scrape_new_format(doc)
    tables = doc.css('table')
    term = T.let(nil, T.nilable(Term))

    tables.each do |table|
      header_label = table.css('thead tr:first-child th:first-child').text.strip
      year = header_label[-2..]
      term = T.must(Term.find_by(term: "#{year}1"))

      Rails.logger.info "Parsing dates for: #{term.readable}"

      table.css('tbody tr').each do |tr|
        columns = tr.css('td')
        label = columns[0]&.text&.strip
        start_day = columns[2]&.text&.strip
        end_day = columns[3]&.text&.strip
        next if start_day.blank? || start_day == 'Dates vary'

        start_date = Date.parse("#{start_day} #{term.year}")
        end_date = Date.parse("#{end_day} #{term.year}")
        next unless label && start_date && end_date

        case label
        when 'A'
          Rails.logger.info "Found start date for Session A: #{start_date}"
          term.session_a_start = start_date
        when 'B'
          Rails.logger.info "Found start date for Session B: #{start_date}"
          term.session_b_start = start_date
        when 'C'
          Rails.logger.info "Found start date for Session C: #{start_date}"
          term.session_c_start = start_date
        when 'D'
          Rails.logger.info "Found start date for Session D: #{start_date}"
          term.session_d_start = start_date
        end

        term.start_date = start_date if term.start_date.nil? || start_date < term.start_date
        term.end_date = end_date if term.end_date.nil? || end_date > term.end_date
      end

      term.save!
    end
  end

  sig { params(doc: T.untyped).void }
  def self.scrape_old_format(doc)
    tables = doc.css('.table')
    term = T.let(nil, T.nilable(Term))

    tables.each do |table|
      header_label = table.css('thead tr th:first-child').text.strip
      year = header_label[-2..]
      term = T.must(Term.find_by(term: "#{year}1"))

      Rails.logger.info "Parsing dates for: #{term.readable}"
      table.css('tbody tr').each do |tr|
        columns = tr.css('td')
        label = columns[0]&.text&.strip
        start_day = columns[1]&.text&.strip
        end_day = columns[2]&.text&.strip
        next if start_day.blank? || end_day.blank? || start_day == 'Dates vary'

        start_date = Date.parse("#{start_day} #{term.year}")
        end_date = Date.parse("#{end_day} #{term.year}")
        next unless label && start_date

        case label
        when /^Session A/
          Rails.logger.info "Found start date for Session A: #{start_date}"
          term.session_a_start = start_date
        when /^Session B/
          Rails.logger.info "Found start date for Session B: #{start_date}"
          term.session_b_start = start_date
        when /^Session C/
          Rails.logger.info "Found start date for Session C: #{start_date}"
          term.session_c_start = start_date
        when /^Session D/
          Rails.logger.info "Found start date for Session D: #{start_date}"
          term.session_d_start = start_date
        end

        term.start_date = start_date if term.start_date.nil? || start_date < term.start_date
        term.end_date = end_date if term.end_date.nil? || end_date > term.end_date
      end

      term.save!
    end
  end
end
