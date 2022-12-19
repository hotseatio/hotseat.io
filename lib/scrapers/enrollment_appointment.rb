# typed: strict
# frozen_string_literal: true

module EnrollmentAppointmentScraper
  extend T::Sig
  include Kernel

  sig { params(year_url: String).void }
  def self.scrape(year_url)
    if year_url > '2020'
      scrape_new_format(year_url)
    else
      scrape_old_format(year_url)
    end
  end

  sig { params(year_url: String).void }
  def self.scrape_new_format(year_url)
    Rails.logger.info('Scraping new format')
    doc = retrieve_doc(year_url)

    term_headings = doc.css('h2').select { |e| e.text.strip.match(/20[0-9]{2}/) }
    term_tables = doc.css('div[data-custom-embed-title]')
    term_headings.each_with_index do |term_heading, i|
      heading_text = term_heading.text
      content = term_tables[i]

      Rails.logger.info("Scanning heading: #{heading_text}")

      code = heading_text[-2..] + heading_text[0]
      term = T.must(Term.find_by(term: code))

      content.css('table').each do |table|
        header = table.at_css('thead')
        body = table.at_css('tbody')

        header_text = header.at_css('tr').text.strip
        pass = T.must(get_pass(header_text))

        body.css('tr').each do |tr|
          tds = tr.css('td')
          parse_pass_row(tds, pass, term.year, term)
        end
      end
    end
  end

  sig { params(header_text: String).returns(T.nilable(Symbol)) }
  def self.get_pass(header_text)
    if header_text.start_with?('PRIORITY')
      :priority_pass
    elsif header_text.start_with?('FIRST')
      :first_pass
    elsif header_text.start_with?('SECOND')
      :second_pass
    elsif header_text.start_with?('GRADUATE')
      :graduate_pass
    end
  end

  sig { params(year_url: String).void }
  def self.scrape_old_format(year_url)
    doc = retrieve_doc(year_url)
    term_headings = doc.css('h3').select { |e| e.text.strip.match(/20[0-9]{2}/) }

    doc.css('.table.table-striped').each do |table|
      heading_idx = (term_headings.bsearch_index { |e| (table <=> e).negative? } || term_headings.length) - 1
      title = term_headings[heading_idx].text.strip
      term_year = title.match(/20[0-9]{2}/)[0]
      term_str = term_year[2..3] + title[0]
      term = T.must(Term.find_by(term: term_str))

      pass = T.let(nil, T.nilable(Symbol))
      state = :find_pass_start

      table.css('tr').each do |tr|
        case state
        when :find_pass_start
          colspan = tr.at_css('td')['colspan']
          if colspan && colspan.strip.present?
            text = tr.at_css('td').text
            pass, state = parse_header_row(pass, state, text)
          end
        when :pass
          tds = tr.css('td')
          if tds.length <= 1
            state = :find_pass_start
          else
            parse_pass_row(tds, T.must(pass), term_year, term)
          end
        end
      end
    end
  end

  sig { params(pass: T.nilable(Symbol), state: Symbol, row_text: String).returns([T.nilable(Symbol), Symbol]) }
  def self.parse_header_row(pass, state, row_text)
    raise 'State machine broke! Found ends when looking for pass start' if /ends/i.match?(row_text)

    case row_text
    when /priority/i
      %i[priority_pass pass]
    when /first/i
      %i[first_pass pass]
    when /second/i
      %i[second_pass pass]
    when /graduate/i
      %i[graduate_pass pass]
    else
      [pass, state]
    end
  end

  sig { params(year_url: String).returns(T.untyped) }
  def self.retrieve_doc(year_url)
    raw_input = if year_url.start_with?('http')
                  HTTParty.get(year_url)
                else
                  Rails.root.join(year_url).read
                end
    Nokogiri.HTML(raw_input)
  end

  sig do
    params(
      row_data: Nokogiri::XML::NodeSet,
      pass: Symbol,
      term_year: String,
      term: Term,
    ).void
  end
  def self.parse_pass_row(row_data, pass, term_year, term)
    if row_data.length != 5
      Rails.logger.warn("Found a row with different from 5 <td>s: #{row_data.length}; ignoring")
      return
    end
    standing_label  = row_data[0].text
    first_appt_date = row_data[1].text
    first_appt_time = row_data[2].text
    last_appt_date  = row_data[3].text
    last_appt_time  = row_data[4].text

    case standing_label
    when /all priority/i
      standings = [nil]
    when /declared candidacy/i
      standings = %i[graduating_senior]
    when /160 or more/i
      standings = %i[almost_graduating_senior]
    when /159/i
      standings = %i[senior]
    when /134/i
      standings = %i[junior]
    when /89/i
      standings = %i[sophomore]
    when /44/i
      standings = %i[freshman]
    when /all graduate/i
      standings = %i[joint_graduate graduate]
    when /joint/i
      standings = %i[joint_graduate]
    when /other graduate/i
      standings = %i[graduate]
    else
      standings = []
      standings << :new_student if /new/i.match?(standing_label)
      standings << :readmitted  if /re-?admitted/i.match?(standing_label)
      standings << :visiting    if /visiting/i.match?(standing_label)
      raise "unknown standing: #{standing_label}" if standings.empty?
    end

    first = parse_date(term_year.to_i, first_appt_date, first_appt_time)
    last = parse_date(term_year.to_i, last_appt_date, last_appt_time)

    standings.each do |standing|
      EnrollmentAppointment
        .find_or_initialize_by(
          term:,
          pass:,
          standing:,
        )
        .update!(
          first:,
          last:,
        )
    end
  end

  sig do
    params(
      term_year: Integer,
      date: String,
      time: String,
    ).returns(ActiveSupport::TimeWithZone)
  end
  def self.parse_date(term_year, date, time)
    zone = Time.find_zone!('America/Los_Angeles')
    tentative_date = zone.parse("#{date} #{time}")
    # Winter quarters have enrollment appointments in the previous year.
    year = tentative_date.month >= 10 ? term_year - 1 : term_year
    zone.parse("#{date}, #{year}, #{time}")
  end
end
