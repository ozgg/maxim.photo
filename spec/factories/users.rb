FactoryGirl.define do
  factory :user do
    sequence(:slug) { |n| "user#{n}" }
    password 'secret'
    password_confirmation 'secret'
  end
end
