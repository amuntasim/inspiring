FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "#{Faker::Lorem.word}#{n}" }
    category "story"
  end
end
