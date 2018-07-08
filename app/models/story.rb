class Story < ApplicationRecord
  acts_as_paranoid
  has_many_attached :photos

  belongs_to :brand, optional: true, counter_cache: true
  belongs_to :user, counter_cache: true
  belongs_to :category, optional: true, counter_cache: :items_count

  validates :user_id, presence: true
  validates :description, presence: true

  has_many :taggings, as: :taggable, validate: false
  has_many :tags, through: :taggings, validate: false
  has_many :comments
  has_many :inspirations, as: :inspiring

  accepts_nested_attributes_for :photos_attachments, allow_destroy: true

  delegate :name, to: :category, prefix: true, allow_nil: true

  def inspired?(user)
    Inspiration.stories.where(inspiring_id: self.id, user_id: user&.id).any?
  end

  before_update :purge_blobs

  private
  def purge_blobs
    photos_attachments.each do |photo_attachment|
      if photo_attachment.marked_for_destruction?
        photo_attachment.blob.purge_later
      end
    end
  end
end
