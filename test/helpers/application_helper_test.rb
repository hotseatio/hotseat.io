# typed: strict
# frozen_string_literal: true

require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  describe "full title" do
    it "returns the site title" do
      assert_equal("Hotseat: Data-driven course enrollment for UCLA", full_title)
    end

    it "returns the page and site title if given a page title" do
      assert_equal("Log in | Hotseat", full_title("Log in"))
    end
  end

  describe "get alert color" do
    it "returns red for error or alert" do
      assert_equal(ColorHelper::Color::Red, get_alert_color("error"))
      assert_equal(ColorHelper::Color::Red, get_alert_color("alert"))
    end

    it "returns blue by default" do
      assert_equal(ColorHelper::Color::Blue, get_alert_color("blah"))
    end
  end

  describe "get alert symbol" do
    it "returns an x circle for error or alert" do
      assert_equal("x-circle", get_alert_symbol("error"))
      assert_equal("x-circle", get_alert_symbol("alert"))
    end

    it "returns an info circle by default" do
      assert_equal("information-circle", get_alert_symbol("blah"))
    end
  end

  describe "#show_ads" do
    it "doesn't show ads in test mode" do
      T.unsafe(Rails).stubs(:env).returns(ActiveSupport::StringInquirer.new("test"))
      T.unsafe(self).expects(:current_page?).times(4).returns(false)
      assert_not(show_ads?)
    end

    it "doesn't show ads on the home page" do
      T.unsafe(Rails).stubs(:env).returns(ActiveSupport::StringInquirer.new("production"))
      T.unsafe(self).expects(:current_page?).with(root_path).returns(true)
      assert_not(show_ads?)
    end

    it "doesn't show ads on the privacy page" do
      T.unsafe(Rails).stubs(:env).returns(ActiveSupport::StringInquirer.new("production"))
      T.unsafe(self).expects(:current_page?).with(root_path).returns(false)
      T.unsafe(self).expects(:current_page?).with(page_path("privacy")).returns(true)
      assert_not(show_ads?)
    end

    it "doesn't show ads on the terms page" do
      T.unsafe(Rails).stubs(:env).returns(ActiveSupport::StringInquirer.new("production"))
      T.unsafe(self).expects(:current_page?).with(root_path).returns(false)
      T.unsafe(self).expects(:current_page?).with(page_path("privacy")).returns(false)
      T.unsafe(self).expects(:current_page?).with(page_path("terms")).returns(true)
      assert_not(show_ads?)
    end

    it "doesn't show ads on the faq" do
      T.unsafe(Rails).stubs(:env).returns(ActiveSupport::StringInquirer.new("production"))
      T.unsafe(self).expects(:current_page?).with(root_path).returns(false)
      T.unsafe(self).expects(:current_page?).with(page_path("privacy")).returns(false)
      T.unsafe(self).expects(:current_page?).with(page_path("terms")).returns(false)
      T.unsafe(self).expects(:current_page?).with(page_path("faq")).returns(true)
      assert_not(show_ads?)
    end

    it "shows ads otherwise" do
      T.unsafe(Rails).stubs(:env).returns(ActiveSupport::StringInquirer.new("production"))
      T.unsafe(self).expects(:current_page?).times(4).returns(false)
      assert_predicate(self, :show_ads?)
    end
  end
end
