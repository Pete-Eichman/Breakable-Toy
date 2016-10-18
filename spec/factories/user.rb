require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "first_name#{n}" }
    sequence(:last_name) { |n| "last_name#{n}" }
    sequence(:phone_number){ |n| "555-555-511{n}" }
    sequence(:email) { |n| "#{n}@launchacademy.com" }
    password "abcdef1234"
    password_confirmation "abcdef1234"
    factory :admin do
      admin true
    end
    factory :owner do
      owner true
    end
  end
end
