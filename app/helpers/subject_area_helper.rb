# typed: strict
# frozen_string_literal: true

module SubjectAreaHelper
  extend T::Sig

  class FilterOption < T::Enum
    extend T::Sig
    enums do
      All = new
    end
  end

  sig { params(subject_area: SubjectArea, current_option: T.any(FilterOption, Term), options: Term::RelationType).returns(T::Array[{ key: String, label: String, url: String, selected: T::Boolean }]) }
  def self.filter_links(subject_area, current_option, options)
    links = FilterOption.values.map do |value|
      serialized_value = T.cast(value.serialize, String)
      {
        key: serialized_value,
        label: serialized_value.titlecase,
        url: Rails.application.routes.url_helpers.subject_area_path(subject_area, filter: serialized_value),
        selected: current_option.is_a?(FilterOption) && current_option == value,
      }
    end
    links += options.map do |term|
      {
        key: term.term,
        label: term.readable,
        url: Rails.application.routes.url_helpers.subject_area_path(subject_area, filter: term.term),
        selected: current_option.is_a?(Term) && current_option == term,
      }
    end
    links
  end

  sig { params(subject_area: SubjectArea).returns(String) }
  def subject_area_description(subject_area)
    "Find #{subject_area.name_and_code} courses, reviews, and professors. Provided by Hotseat, UCLA's premier source for professors and classes."
  end
end
