FactoryBot.define do
  factory :inspiration do
    user_id 1
    inspiring_id 1
    inspiring_type 'Story'

    trait :brand do
      inspiring {create(:brand)}
    end

    trait :story do
      inspiring {create(:story)}
    end
  end
end
