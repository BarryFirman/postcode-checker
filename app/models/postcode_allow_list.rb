# frozen_string_literal: true

# Postcodes to be treated as valid for searches
class PostcodeAllowList < ApplicationRecord

  validate :ensure_valid_postcode
  before_save :shape_postcode
  before_create :shape_postcode
  validates_uniqueness_of :postcode, case_sensitive: false



  private

  def ensure_valid_postcode
    errors.add(:postcode, 'invalid postcode format') unless Services::PostcodeValidator.valid_format? postcode
  end

  def shape_postcode
    self.postcode = Services::PostcodeValidator.shape_postcode postcode
  end
end
