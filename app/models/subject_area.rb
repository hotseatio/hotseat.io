# typed: strict
# frozen_string_literal: true

class SubjectArea < ApplicationRecord
  extend T::Sig

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  has_one :preceding_subject_area,
          class_name: "SubjectArea",
          foreign_key: "superseding_subject_area_id",
          inverse_of: :superseding_subject_area,
          dependent: :restrict_with_exception
  belongs_to :superseding_subject_area,
             class_name: "SubjectArea",
             optional: true

  has_many :courses, dependent: :restrict_with_exception
  has_many :terms, -> { distinct.reorder("") }, through: :courses

  scope :order_by_name, -> { order("name ASC") }
  scope :active, -> { where(superseding_subject_area: nil) }

  sig { returns(ActiveRecord::Relation) }
  def self.most_popular
    most_popular_names = [
      "Art History",
      "Communication",
      "Computer Science",
      "Economics",
      "English",
      "Film and Television",
      "Geography",
      "History",
      "Life Sciences",
      "Linguistics",
      "Mathematics",
      "Music",
      "Philosophy",
      "Physics",
      "Political Science",
      "Psychology",
      "Sociology",
      "Statistics",
    ]
    active.where(name: most_popular_names)
  end

  sig { returns(String) }
  def name_and_code
    "#{name} (#{code})"
  end
end
