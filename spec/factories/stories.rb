FactoryBot.define do
  factory :story do
    user_id 1
    title Faker::Lorem.sentence
    description {Faker::Lorem.paragraph(rand(30))}
  end
end
