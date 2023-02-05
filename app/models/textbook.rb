# typed: strict
# frozen_string_literal: true

AFFILIATE_TAG = "hotseat0c-20"

class Textbook < ApplicationRecord
  extend T::Sig

  has_and_belongs_to_many :sections

  sig { returns(String) }
  def sublabel
    author = self.author
    edition = edition_label
    required = required_label

    if edition && required
      "#{edition} (#{required})"
    elsif edition
      edition
    elsif required
      required
    elsif author
      author
    else
      ""
    end
  end

  sig { returns(String) }
  def amazon_link
    if isbn10
      # Link directly to product page
      "https://www.amazon.com/gp/product/#{isbn10}?tag=#{AFFILIATE_TAG}"
    else
      # Link to a search page with the isbn13
      "https://www.amazon.com/s/ref=as_li_ss_tl?k=#{isbn13}&tag=#{AFFILIATE_TAG}"
    end
  end

  private

  sig { returns(T.nilable(String)) }
  def isbn10
    Lisbn.new(isbn).isbn10
  end

  sig { returns(T.nilable(String)) }
  def isbn13
    Lisbn.new(isbn).isbn13
  end

  sig { returns(T.nilable(String)) }
  def edition_label
    edition = self.edition
    return nil if edition.nil?

    "#{edition.ordinalize} edition"
  end

  sig { returns(T.nilable(String)) }
  def required_label
    is_required = self.is_required
    return nil if is_required.nil?

    is_required ? "Required" : "Optional"
  end
end
