class Story < ApplicationRecord
  acts_as_paranoid
  has_one_attached :cover_photo

  belongs_to :brand, optional: true, counter_cache: true
  belongs_to :user, counter_cache: true
  belongs_to :category, optional: true, counter_cache: :items_count

  validates :user_id, presence: true
  validates :description, presence: true

  has_many :taggings, as: :taggable, validate: false
  has_many :tags, through: :taggings , validate: false
  has_many :comments

  delegate :name, to: :category , prefix: true, allow_nil: true
end
