# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `ReviewsController`.
# Please instead update this file by running `bin/tapioca dsl ReviewsController`.

class ReviewsController
  sig { returns(HelperProxy) }
  def helpers; end

  module HelperMethods
    include ::Turbo::DriveHelper
    include ::Turbo::FramesHelper
    include ::Turbo::IncludesHelper
    include ::Turbo::StreamsHelper
    include ::Turbo::Streams::ActionHelper
    include ::ActionText::ContentHelper
    include ::ActionText::TagHelper
    include ::ActionController::Base::HelperMethods
    include ::ApplicationHelper
    include ::ColorHelper
    include ::ActionView::Helpers::SanitizeHelper
    include ::ActionView::Helpers::CaptureHelper
    include ::ActionView::Helpers::OutputSafetyHelper
    include ::ActionView::Helpers::TagHelper
    include ::ActionView::Helpers::TextHelper
    include ::CourseHelper
    include ::InstructorHelper
    include ::ReviewHelper
    include ::SectionHelper
    include ::SubjectAreaHelper
    include ::TermHelper
    include ::UserHelper
    include ::Pay::ApplicationHelper
    include ::DeviseHelper
  end

  class HelperProxy < ::ActionView::Base
    include HelperMethods
  end
end
