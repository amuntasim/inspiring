class Brand < ApplicationRecord
  acts_as_paranoid

  has_one_attached :logo
  has_one_attached :cover_photo

  belongs_to :user
  belongs_to :category, validate: false, counter_cache: :items_count

  validates :user_id, presence: true
  validates :name, presence: true

  has_many :reviews, as: :reviewable
  has_many :inspirations , as: :inspiring

  has_many :taggings, as: :taggable, validate: false
  has_many :tags, through: :taggings , validate: false

  delegate :name, to: :category , prefix: true, allow_nil: true


  before_destroy :check_deletable

  def main_image_url(style = 'medium')
    first_image =  images.first
    first_image.image.url(style) if first_image
  end
  
  def id_name
    "#{id}-#{name}"
  end

  private
  def check_deletable
    if reservations.any? || spaces.any?
      errors.add(:base, I18n.t('label.not_deletable'))
      return false
    end
  end
end
