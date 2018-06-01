FactoryBot.define do
  factory :brand do
    user_id 1
    latitude 1
    longitude 1
    sequence(:name) { |n| "#{ Faker::Lorem.words(2).join(' ')}#{n}" }
    address  Faker::Address.full_address
    description  Faker::Lorem.paragraphs
    sequence(:email) do |n|
      "#{n}#{Faker::Internet.email}"
    end
    web Faker::Internet.domain_name
    phone Faker::PhoneNumber.cell_phone
  end
end
