FactoryBot.define do
  factory :inspiration do
    user_id 1
    inspiring_id 1

    trait :brand do
      inspiring_id 'Brand'
    end

    trait :story do
      inspiring_id 'Story'
    end
  end
end
