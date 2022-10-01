# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `letter_opener` gem.
# Please instead update this file by running `bin/tapioca gem letter_opener`.

module LetterOpener
  class << self
    def configuration; end

    # @yield [configuration]
    def configure; end
  end
end

class LetterOpener::Configuration
  # @return [Configuration] a new instance of Configuration
  def initialize; end

  # Returns the value of attribute file_uri_scheme.
  def file_uri_scheme; end

  # Sets the attribute file_uri_scheme
  #
  # @param value the value to set the attribute file_uri_scheme to.
  def file_uri_scheme=(_arg0); end

  # Returns the value of attribute location.
  def location; end

  # Sets the attribute location
  #
  # @param value the value to set the attribute location to.
  def location=(_arg0); end

  # Returns the value of attribute message_template.
  def message_template; end

  # Sets the attribute message_template
  #
  # @param value the value to set the attribute message_template to.
  def message_template=(_arg0); end
end

class LetterOpener::DeliveryMethod
  # @raise [InvalidOption]
  # @return [DeliveryMethod] a new instance of DeliveryMethod
  def initialize(options = T.unsafe(nil)); end

  def deliver!(mail); end

  # Returns the value of attribute settings.
  def settings; end

  # Sets the attribute settings
  #
  # @param value the value to set the attribute settings to.
  def settings=(_arg0); end

  private

  def validate_mail!(mail); end
end

class LetterOpener::DeliveryMethod::InvalidOption < ::StandardError; end

class LetterOpener::Message
  # @raise [ArgumentError]
  # @return [Message] a new instance of Message
  def initialize(mail, options = T.unsafe(nil)); end

  def <=>(other); end
  def attachment_filename(attachment); end
  def auto_link(text); end
  def bcc; end
  def body; end
  def cc; end
  def content_type; end
  def encoding; end
  def filepath; end
  def from; end
  def h(content); end

  # Returns the value of attribute mail.
  def mail; end

  def render; end
  def reply_to; end
  def sender; end
  def subject; end
  def template; end
  def to; end
  def type; end

  class << self
    def rendered_messages(mail, options = T.unsafe(nil)); end
  end
end

LetterOpener::Message::ERROR_MSG = T.let(T.unsafe(nil), String)
class LetterOpener::Railtie < ::Rails::Railtie; end