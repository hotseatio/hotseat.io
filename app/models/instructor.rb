# typed: strict
# frozen_string_literal: true

# An instructor for a course. Multiple people can be a single instructor.
class Instructor < ApplicationRecord
  extend T::Sig
  # Keep this in sync with lambdas/registrar/storage.go.
  searchkick word_middle: [:search_text], default_fields: [:search_text]

  has_many :sections, dependent: :restrict_with_exception

  has_many :courses, -> { distinct }, through: :sections
  has_many :subject_areas, -> { distinct }, through: :courses
  has_many :reviews, through: :sections

  sig { returns(T::Hash[Symbol, String]) }
  def search_data
    text = if first_names.blank? || last_names.blank?
             T.must(registrar_listing).join(" ")
           else
             T.must(first_names)
              .zip(T.must(last_names))
              .map { |name_parts| full_name(name_parts.first, name_parts.second) }
              .join(" ")
           end
    text += " #{preferred_label}" if preferred_label.present?

    {
      search_text: text,
    }
  end

  # The instructors' first + last names.
  sig { returns(String) }
  def full_label
    if first_names.blank? || last_names.blank?
      preferred_label.presence || case name_count
                                  when 1
                                    T.must(T.must(registrar_listing).first)
                                  when 2
                                    T.must(registrar_listing).to_sentence
                                  else
                                    "#{T.must(registrar_listing).first} et al."
                                  end
    else
      full_names = T.must(first_names).zip(T.must(last_names))
      preferred_label.presence || case name_count
                                  when 1
                                    first_name, last_name = full_names.first
                                    full_name(first_name, last_name)
                                  when 2
                                    full_names
                                      .map { |name_parts| full_name(name_parts.first, name_parts.second) }
                                      .to_sentence
                                  else
                                    first_name, last_name = full_names.first
                                    "#{full_name(first_name, last_name)} et al."
                                  end
    end
  end

  # The instructors' last names.
  sig { returns(String) }
  def short_label
    if first_names.blank? || last_names.blank?
      preferred_label.presence || case name_count
                                  when 1
                                    T.must(T.must(registrar_listing).first)
                                  when 2
                                    T.must(registrar_listing).to_sentence
                                  else
                                    "#{T.must(registrar_listing).first} et al."
                                  end
    else
      preferred_label.presence || case name_count
                                  when 1
                                    T.must(T.must(last_names).first)
                                  when 2
                                    T.must(last_names).to_sentence
                                  else
                                    "#{T.must(last_names).first} et al."
                                  end
    end
  end

  sig { returns(T.nilable(String)) }
  def first_full_name
    return nil if first_names.blank? || last_names.blank?

    "#{T.must(first_names).first} #{T.must(last_names).first}" if name_count.positive?
  end

  sig { returns(Integer) }
  def name_count
    return T.must(first_names).length if first_names.present?

    T.must(registrar_listing).length
  end

  private

  sig { params(first_name: T.nilable(String), last_name: T.nilable(String)).returns(String) }
  def full_name(first_name, last_name)
    "#{first_name} #{last_name}"
  end
end
