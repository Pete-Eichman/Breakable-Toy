require 'factory_girl_rails'

FactoryGirl.define do
  factory :parking_pass do
    sequence(:pass_number) { |n| "#{n}" }
    sequence(:address) { |n| "#{n}" }
    sequence(:price_per_hour){ |n| "${n}" }
  end
end
