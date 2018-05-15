FactoryBot.define do
  factory :brand do
    user_id 1
    latitude 1
    longitude 1
    name "MyString"
    sequence(:email) do |n|
      "#{n}#{Faker::Internet.email}"
    end
    web "MyString"
    phone "MyString"
  end
end
