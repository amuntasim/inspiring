FactoryBot.define do
  factory :comment do
    story_id 1
    user_id 1
    body "MyText"
    parent_id 1
  end
end
