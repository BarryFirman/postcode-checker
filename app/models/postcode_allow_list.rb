# frozen_string_literal: true

# Postcodes to be treated as valid for searches
class PostcodeAllowList < ApplicationRecord
  require 'uk_postcode'

  validate :ensure_postcode_format
  validates_uniqueness_of :postcode, case_sensitive: false
  before_save :upcase_postcode



  private

  def ensure_postcode_format
    pc = UKPostcode.parse(postcode)
    errors.add(:postcode, 'invalid postcode format') unless pc.valid?
  end

  def upcase_postcode
    postcode.upcase!
  end
end
