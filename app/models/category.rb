class Category < ActiveRecord::Base
  CATEGORY_FOR = ['story', 'brand']

  validates :name, presence: true, uniqueness: true

  after_save :reset_cache
  before_destroy :reset_cache
  has_many :stories
  has_many :spaces

  scope :for, ->(category_for) {where(for: category_for)}

  def self.cached_json(category_for = nil)
    Rails.cache.fetch("cached_categories_json//#{category_for}_#{I18n.locale}") do
      cats = Category.includes(:translations)
      cats = cats.for(category_for) if category_for
      cats.collect { |c| {id: c.id, name: c.name} }.to_json
    end
  end

  private
  def reset_cache
    Rails.cache.delete_matched('cached_categories*')
  end
end
