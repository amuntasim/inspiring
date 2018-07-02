class Comment < ApplicationRecord
  validates :story_id, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :story, counter_cache: true
  belongs_to :parent, class_name: "Comment", optional: true,  counter_cache: 'replies_count'
  scope :roots, -> { where(parent_id: nil) }
end
