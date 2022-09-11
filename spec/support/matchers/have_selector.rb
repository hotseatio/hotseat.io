# typed: false
# frozen_string_literal: true

RSpec::Matchers.define :have_selector do |selector, options|
  match do |body|
    element = Nokogiri::HTML(body).at_css(selector)
    if element.present?
      content = options[:content] unless options.nil?
      if content.nil?
        true
      else
        element.text.strip == content
      end
    end
  end

  failure_message do |body|
    "expected that #{body} would contain #{selector}"
  end
end
