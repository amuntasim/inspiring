module DashboardHelper

  def review_on_for_agent(review)
    if review.space
      link_to review.space.name, agent_dashboard_spaces_path(review.space)
    elsif review.brand
      link_to review.brand.name, agent_dashboard_brands_path(review.brand)
    end
  end

  def review_on(review)
    if review.space
      link_to review.space.name, space_properties_path(id: review.brand_id, space_id: review.space_id)
    elsif review.brand
      link_to review.brand.name, properties_path(review.brand)
    end
  end

  def user_avatar_image(user, type=:medium)
    variant = { medium: { resize: "300x300" }, thumb: { resize: "100x100" } }
    user.avatar.attached? ? user.avatar.variant(variant[type]) : image_path("#{type}/avatar.jpg")
  end
end
