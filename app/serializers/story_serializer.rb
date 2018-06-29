class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category_id, :inspirations_count, :created_at, :updated_at
  belongs_to :user
end
