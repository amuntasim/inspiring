class Brand < ApplicationRecord
  acts_as_paranoid

  has_one_attached :logo
  has_one_attached :cover_photo

  belongs_to :user
  belongs_to :category, validate: false, counter_cache: :items_count

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true

  has_many :stories, dependent: :nullify
  has_many :reviews, as: :reviewable
  has_many :inspirations , as: :inspiring

  has_many :taggings, as: :taggable, validate: false
  has_many :tags, through: :taggings , validate: false

  delegate :name, to: :category , prefix: true, allow_nil: true
  before_validation :set_handle, :if => :new_record?

  def main_image_url(style = 'medium')
    first_image =  images.first
    first_image.image.url(style) if first_image
  end
  
  def id_name
    "#{id}-#{name}"
  end

  private

  def set_handle
    self.handle ||= get_unique_handle
  end

  def get_unique_handle
    handle_part = self.name.split(" ").first.downcase
    new_handle = handle_part.dup
    num = 2
    until Brand.find_by_handle(new_handle).nil?
      new_handle = "#{handle_part}#{num}"
      num += 1
    end
    new_handle
  end
end
