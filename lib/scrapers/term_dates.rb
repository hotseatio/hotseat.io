# typed: strict
# frozen_string_literal: true

module TermDatesScraper
  extend T::Sig

  sig { params(file: String).void }
  def self.scrape(file)
    extension = File.extname(file)
    if extension == '.pdf'
      scrape_pdf(file)
    else
      scrape_html(file)
    end
  end

  sig { params(file: String).void }
  def self.scrape_html(file)
    # Read file
    raw_input = Rails.root.join(file).read
    doc = Nokogiri.HTML(raw_input)

    tables = doc.css('.table')

    term = T.let(nil, T.nilable(Term))

    tables.each do |table|
      table.css('tr').each do |tr|
        header = tr.at_css('h4')
        if header.nil?
          label, day = tr.css('td').map { |node| node.text.strip }

          case label
          when /^(Instruction|Summer session) begins/i
            raise 'No term found' if term.nil?

            start_date = "#{day} #{term.year}"
            Rails.logger.info("Found start date: #{start_date}")
            term.start_date = Date.parse(start_date)
          when /^(Quarter|Summer session) ends/i
            raise 'No term found' if term.nil?

            end_date = "#{day} #{term.year}"
            Rails.logger.info("Found end date: #{end_date}")
            term.end_date = Date.parse(end_date)
          end
        else
          # Save the previous term
          term&.save!

          term_label = shortened_quarter_label(header.text)
          Rails.logger.info("Reading for term: #{term_label}")
          term = Term.find_by(term: term_label)
        end
      end

      # Save last term
      term&.save!
    end
  end

  sig { params(file: String).void }
  def self.scrape_pdf(file)
    PDF::Reader.open(file) do |reader|
      term = T.let(nil, T.nilable(Term))

      reader.pages.each do |page|
        page.text.each_line do |line|
          case line.strip
          when /^(FALL|WINTER|SPRING)/
            # Save the previous term
            term&.save!

            term_label = shortened_quarter_label(line)
            Rails.logger.info("Reading for term: #{term_label}")
            term = Term.find_by(term: term_label)
          when /^Instruction begins/i
            raise 'No term found' if term.nil?

            start_date = "#{row_value(line)} #{term.year}"
            Rails.logger.info("Found start date: #{start_date}")
            term.start_date = Date.parse(start_date)
          when /^Quarter ends/i
            raise 'No term found' if term.nil?

            end_date = "#{row_value(line)} #{term.year}"
            Rails.logger.info("Found end date: #{end_date}")
            term.end_date = Date.parse(end_date)
          end
        end
      end

      # Save last term
      term&.save!
    end
  end

  # FALL QUARTER 2000 -> 00F
  sig { params(full_quarter_label: String).returns(String) }
  def self.shortened_quarter_label(full_quarter_label)
    full_quarter_label.strip!
    year = T.must(full_quarter_label[-2..])
    if full_quarter_label.start_with?('Summer')
      "#{year}1"
    else
      year + T.must(full_quarter_label[0]).upcase
    end
  end

  sig { params(line: String).returns(String) }
  def self.row_value(line)
    matches = T.must(/  (.*)$/.match(line)).captures
    T.must(matches[0]).strip
  end
end
