class SocialLink < ApplicationRecord
  USER_LINK_CATEGORIES = %w(twitter facebook google-plus)
  validates :name,  :social_linkable_type, :social_linkable_id, presence: true
  validates :url, presence: true, on: :create
  validates :name, uniqueness: {scope: [:social_linkable_type, :social_linkable_id]}
end
