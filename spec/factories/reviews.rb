FactoryBot.define do
  factory :review do
    reviewable_id 1
    reviewable_type 'Brand'
    rating 1
    user_id 1
    comment "MyText"
  end
end
