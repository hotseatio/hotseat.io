# typed: strict
# frozen_string_literal: true

module ReviewHelper
  extend T::Sig

  class QuestionType < T::Enum
    extend T::Sig

    enums do
      Agreement = new
      Time = new
      Binary = new
      Count = new
      Final = new
    end

    # Returns the range of possible values
    sig { returns(T.any(T::Range[Integer], T::Array[T::Boolean], T::Array[String])) }
    def value_range
      case self
      when Agreement then 1..7
      when Time then Review.weekly_times.values
      when Binary then [false, true]
      when Count then 0..3
      when Final then %w[none 10th finals]
      else
        T.absurd(self)
      end
    end

    sig { params(value: T.any(Integer, T::Boolean, String)).returns(String) }
    def label_for_value(value)
      likert_responses_agreement = {
        1 => 'Strongly disagree',
        2 => 'Disagree',
        3 => 'Somewhat disagree',
        4 => 'Neutral',
        5 => 'Somewhat agree',
        6 => 'Agree',
        7 => 'Strongly agree',
      }
      responses_count = {
        0 => '0',
        1 => '1',
        2 => '2',
        3 => '3 or more',
      }
      responses_binary = {
        false => 'No',
        true => 'Yes',
      }
      responses_final = {
        'none' => 'No',
        '10th' => 'Yes, during 10th week',
        'finals' => 'Yes, during finals week',
      }

      case self
      when Agreement then likert_responses_agreement[value]
      when Time then "#{value} hrs/week"
      when Binary then responses_binary[value]
      when Count then responses_count[value]
      when Final then responses_final[value]
      else
        T.absurd(self)
      end
    end
  end

  sig { returns(T::Array[T::Hash[Symbol, T.any(Symbol, String)]]) }
  def grading_questions
    [
      {
        id: :weekly_time,
        text: 'On average, how much time outside of class did you spent studying, reading, completing homeworks, etc.?',
        type: QuestionType::Time.serialize,
        required: true,
      },
      {
        id: :group_project,
        text: 'Is there a group project part of the class?',
        type: QuestionType::Binary.serialize,
        required: true,
      },
      {
        id: :attendance,
        text: 'Is attendance or participation required?',
        type: QuestionType::Binary.serialize,
        required: true,
      },
      {
        id: :extra_credit,
        text: 'Is there extra credit offered?',
        type: QuestionType::Binary.serialize,
        required: true,
      },
      {
        id: :midterm_count,
        text: 'How many midterms does the class have?',
        type: QuestionType::Count.serialize,
        required: true,
      },
      {
        id: :final,
        text: 'Is there a final? When was it given?',
        type: QuestionType::Final.serialize,
        required: true,
      },
    ]
  end

  sig { returns(T::Array[T::Hash[Symbol, T.any(Symbol, String)]]) }
  def materials_questions
    [
      {
        id: :textbook,
        text: 'Would you recommend reading the textbook/materials for the class?',
        type: QuestionType::Binary.serialize,
        required: true,
      },
    ]
  end

  sig { returns(T::Array[T::Hash[Symbol, T.any(Symbol, String)]]) }
  def overall_review_questions
    [
      {
        id: :organization,
        text: 'Class presentations were well prepared and organized.',
        type: QuestionType::Agreement.serialize,
        required: true,
      },
      {
        id: :clarity,
        text: 'The instructor clearly presented course material and concepts.',
        type: QuestionType::Agreement.serialize,
        required: true,
      },
      # { text: 'The instructor made themselves available to answer questions outside of class.', type: :agreement },
      {
        id: :overall,
        text: 'Overall, I enjoyed taking this course with this instructor.',
        type: QuestionType::Agreement.serialize,
        required: true,
      },
    ]
  end

  sig { returns(T::Array[T::Hash[Symbol, T.untyped]]) }
  def question_sections
    [
      {
        title: 'Overall review',
        questions: overall_review_questions,
      },
      {
        title: 'Grading',
        questions: grading_questions,
      },
      {
        title: 'Materials',
        questions: materials_questions,
      },
    ]
  end
end
