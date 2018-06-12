class Brand < ApplicationRecord
  acts_as_paranoid

  has_one_attached :logo
  has_one_attached :cover_photo

  has_one :user
  belongs_to :category, validate: false, counter_cache: :items_count

  validates :name, presence: true, uniqueness: true

  has_many :stories, dependent: :nullify
  has_many :reviews, as: :reviewable
  has_many :inspirations , as: :inspiring

  has_many :taggings, as: :taggable, validate: false
  has_many :tags, through: :taggings , validate: false

  delegate :name, to: :category , prefix: true, allow_nil: true

  def main_image_url(style = 'medium')
    first_image =  images.first
    first_image.image.url(style) if first_image
  end
  
  def id_name
    "#{id}-#{name}"
  end
end
