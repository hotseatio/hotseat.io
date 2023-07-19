# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Rails::Conductor::ActionMailbox::IncineratesController`.
# Please instead update this file by running `bin/tapioca dsl Rails::Conductor::ActionMailbox::IncineratesController`.

class Rails::Conductor::ActionMailbox::IncineratesController
  sig { returns(HelperProxy) }
  def helpers; end

  module HelperMethods
    include ::Turbo::DriveHelper
    include ::Turbo::FramesHelper
    include ::Turbo::IncludesHelper
    include ::Turbo::StreamsHelper
    include ::ActionView::Helpers::SanitizeHelper
    include ::ActionView::Helpers::CaptureHelper
    include ::ActionView::Helpers::OutputSafetyHelper
    include ::ActionView::Helpers::TagHelper
    include ::Turbo::Streams::ActionHelper
    include ::ActionText::ContentHelper
    include ::ActionText::TagHelper
    include ::ActionController::Base::HelperMethods
    include ::Admin::ReviewsHelper
    include ::ApplicationHelper
    include ::ColorHelper
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
