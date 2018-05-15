class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user, optional: true
  validates :user_id, presence: true
  validates :rating, presence: true
  validates :reviewable_id, uniqueness: { scope: [:user_id, :reviewable_type], message: I18n.t('notifications.already_reviewed') }


  after_create :update_brand_ratings

  private
  def brand_review?
    reviewable_type == 'Brand'
  end

  def update_brand_ratings
    return unless brand_review?
    brand_reviews       = Review.where(reviewable_id: reviewable_id)
    brand_reviews_count = brand_reviews.count
    brand_ratings       = brand_reviews.sum(&:rating)
    reviewable.update_columns(reviews_count: brand_reviews_count, avg_rating: brand_ratings/brand_reviews_count)
  end
end
