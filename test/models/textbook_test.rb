# typed: strict
# frozen_string_literal: true

require "test_helper"

class TextbookTest < ActiveSupport::TestCase
  describe "sublabel" do
    it "returns the edition and required status of the book if both are present" do
      textbook = build(:textbook, edition: 4, is_required: true)
      assert_equal("4th edition (Required)", textbook.sublabel)
    end

    it "returns the edition if the requirement status of the book is unclear" do
      textbook = build(:textbook, edition: 4)
      assert_equal("4th edition", textbook.sublabel)
    end

    it "returns the requirement status if the edition of the book is unclear" do
      textbook = build(:textbook, is_required: false)
      assert_equal("Optional", textbook.sublabel)
    end

    it "returns the author if no edition or requirement info is provided" do
      textbook = build(:textbook, author: "Rogawski")
      assert_equal("Rogawski", textbook.sublabel)
    end

    it "returns empty string if no info is provided" do
      textbook = build(:textbook)
      assert_empty(textbook.sublabel)
    end
  end

  describe "amazon_link" do
    it "returns a link to a product page if an isbn10 exists for the book" do
      textbook = build(:textbook, isbn: "9781429208390")
      assert_equal("https://www.amazon.com/gp/product/1429208392?tag=hotseat0c-20", textbook.amazon_link)
    end

    it "returns a link to search results if no isbn 10 exists" do
      textbook = build(:textbook, isbn: "9798655930292")
      assert_equal("https://www.amazon.com/s/ref=as_li_ss_tl?k=9798655930292&tag=hotseat0c-20", textbook.amazon_link)
    end
  end
end
