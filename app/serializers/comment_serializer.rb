class CommentSerializer < ActiveModel::Serializer
  attributes :id, :story_id, :replies_count, :body, :parent_id, :created_at
  belongs_to :user
end
