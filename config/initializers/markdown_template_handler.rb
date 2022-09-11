# typed: true
# frozen_string_literal: true

# Stolen from https://stackoverflow.com/questions/56715152/using-erb-in-markdown-with-redcarpet

require 'redcarpet'

class MarkdownTemplateHandler
  extend T::Sig

  sig { returns(T.untyped) }
  def erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  sig { params(template: T.untyped, source: T.untyped).returns(String) }
  def call(template, source)
    compiled_source = erb.call(template, source)
    "Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render(begin;#{compiled_source};end).html_safe"
  end
end

ActionView::Template.register_template_handler(:md, MarkdownTemplateHandler.new)
