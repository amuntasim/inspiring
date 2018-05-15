FactoryBot.define do
  factory :user do
    name "Test User"
    sequence(:email) do |n|
      "#{n}#{Faker::Internet.email}"
    end
    password "Abcd1234"

    trait :admin do
      role 'admin'
    end
  end
end
