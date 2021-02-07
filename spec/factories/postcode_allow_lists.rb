# frozen_string_literal: true

FactoryBot.define do
  factory :postcode_allow_list do
    trait :valid do
      postcode { 'SE1 7QD' }
    end
    trait :invalid do
      postcode { 'invalid_postcode' }
    end
  end

end
