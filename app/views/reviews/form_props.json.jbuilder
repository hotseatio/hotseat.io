# typed: strict
# frozen_string_literal: true

json = T.unsafe(json)
json.key_format!(camelize: :lower)

@initial_suggestion_type = T.let(@initial_suggestion_type, T.nilable(String))
@course = T.let(@course, T.nilable(Course))
@term = T.let(@term, T.nilable(Term))
@section = T.let(@section, T.nilable(Section))
@review = T.let(@review, T.nilable(Review))

extend ReviewHelper # rubocop:disable Style/MixinUsage

json.review do
  # If a review doesn't have a section yet, then it's a new review. Set `review` to null.
  # The `review` key should only be used when editing.
  if @review&.section
    json.partial!("reviews/review", review: @review)
  else
    json.null!
  end
end
json.question_sections(question_sections)
json.grades(Review.grades.values)
json.create_url(reviews_url)
json.edit_url(review_url(@review))
json.courses_url(reviews_course_suggestions_url)
json.section_suggestions_url(reviews_section_suggestions_url)
json.term_suggestions_url(reviews_term_suggestions_url)
json.initial_suggestion do
  if @initial_suggestion_type.nil?
    json.null!
  else
    @course = T.must(@course)
    json.type(@initial_suggestion_type)
    json.course do
      json.id(@course.id)
      json.title(@course.title)
      json.number(@course.number)
      json.subject_area_code(@course.subject_area_code)
    end
    if @initial_suggestion_type == "section"
      json.term_suggestion do
        json.partial!("reviews/term_suggestions", course: @course)
      end
      json.selected_term do
        json.partial!("terms/term", term: @term)
      end
      json.sections do
        json.partial!("sections/section", collection: @sections, as: :section)
      end
      json.selected_section do
        json.partial!("sections/section", section: @section, as: :section)
      end
    end
  end
end
