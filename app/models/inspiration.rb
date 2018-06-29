class Inspiration < ApplicationRecord
  belongs_to :user
  belongs_to :inspiring, polymorphic: true, counter_cache: true, optional: true
  validates :user_id, presence: true
  validates :inspiring_id, presence: true, uniqueness: { scope: [:user_id, :inspiring_type], message: I18n.t('notifications.already_inspired') }

  scope :stories, -> { where(inspiring_type: 'Story') }

  after_save :reset_cache
  before_destroy :reset_cache

  def self.inspired_ids(inspiring_type, user_id)
    Rails.cache.fetch("inspired_users/#{inspiring_type}/#{user_id}") do
      Inspiration.where(user_id: user_id).pluck(:inspiring_id)
    end
  end

  def self.create_or_destroy!(inspiring, user_id)
    inspiration = inspiring.inspirations.where(user_id: user_id).last
    if inspiration
      inspiration.destroy!
    else
      inspiration = inspiring.inspirations.create(user_id: user_id)
    end
    inspiration
  end

  private
  def reset_cache
    Rails.cache.delete("inspired_users/#{inspiring_type}/#{user_id}")
  end
end
