class Inspiration < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :inspiring, polymorphic: true, counter_cache: true
  validates :user_id, presence: true
  validates :inspiring_id, presence: true, uniqueness: { scope: [:user_id, :inspiring_type], message: I18n.t('notifications.already_inspired') }

  scope :stories, -> { where(inspiring_type: 'Story') }

  after_save :reset_cache
  after_create :add_inspiration_points
  before_destroy :reset_cache, :deduct_inspiration_points

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

  def inspiring_user
    @inspiring_user ||= inspiring.user
  end

  def deduct_inspiration_points
    inspiring_user.with_lock do
      inspiring_user.inspiration_points -= 1
      inspiring_user.save!
    end
  end

  def add_inspiration_points
    inspiring_user.with_lock do
      inspiring_user.inspiration_points += 1
      inspiring_user.save!
    end
  end
end
