class Tag < ApplicationRecord
  CATEGORIES = ['space', 'property']

  validates :name, :presence => true

  after_save :reset_cache
  before_destroy :reset_cache

  def self.cached_json(category = nil)
    Rails.cache.fetch("cached_tags_json/#{category}_#{I18n.locale}") do
      tags = Tag.includes(:translations)
      tags = tags.where(category: category) if category
      tags.collect { |c| {id: c.id, name: c.name} }.to_json
    end
  end

  private
  def reset_cache
    Rails.cache.delete_matched('cached_tags*')
  end
end
