# typed: strict
# frozen_string_literal: true

module ApplicationHelper
  extend T::Sig

  # Returns 'current' if the given path is the current page.
  # Useful for adding a CSS class to links/other elements that
  # should be styled differently when on a given page.
  sig { params(path: String).returns(String) }
  def cp(path)
    current_page?(path) ? "current" : ""
  end

  # Returns the full title on a per-page basis.
  sig { params(page_title: String).returns(String) }
  def full_title(page_title = "")
    base_title = "Hotseat"
    if page_title.empty?
      "#{base_title}: Data-driven course enrollment for UCLA"
    else
      "#{page_title} | #{base_title}"
    end
  end

  # Returns the full description on a per-page basis.
  sig { params(page_description: String).returns(String) }
  def full_description(page_description = "")
    base_description = "Hotseat is UCLA's premier source on professor and course information. Find reviews, grades, enrollments, textbooks, and more."
    page_description.presence || base_description
  end

  # Returns the color an alert box should be.
  sig { params(alert_type: String).returns(ColorHelper::Color) }
  def get_alert_color(alert_type)
    case alert_type
    when "alert", "error"
      ColorHelper::Color::Red
    when "warn"
      ColorHelper::Color::Yellow
    when "success"
      ColorHelper::Color::Green
    else
      ColorHelper::Color::Blue
    end
  end

  # Returns the symbol a alert box should have.
  sig { params(alert_type: String).returns(String) }
  def get_alert_symbol(alert_type)
    case alert_type
    when "alert", "error"
      "x-circle"
    when "warn"
      "exclamation"
    when "success"
      "check-circle"
    else
      "information-circle"
    end
  end

  sig { params(component_name: String, props: T.any(T::Hash[Symbol, T.untyped], String), html_options: T::Hash[Symbol, T.untyped]).returns(String) }
  def react_component_transparent(component_name, props: {}, html_options: {})
    stringified_props = if props.is_a?(String)
                          props
                        else
                          props.to_json
                        end
    content_tag(:div, nil, id: component_name, "data-react-props": stringified_props, **html_options)
  end

  sig { returns(T::Boolean) }
  def show_ads?
    (!(current_page?(root_path) or
    current_page?(page_path("privacy")) or
    current_page?(page_path("terms")) or
      current_page?(page_path("faq"))) and !T.unsafe(Rails.env).test?
    )
  end
end
