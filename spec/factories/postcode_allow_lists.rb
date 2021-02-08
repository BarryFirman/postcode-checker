# frozen_string_literal: true

FactoryBot.define do
  factory :postcode_allow_list do
    trait :valid do
      postcode { 'SH24 1AA' }
    end
    trait :invalid do
      postcode { 'invalid_postcode' }
    end
  end

end
