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

  def user_cover_photo(user, type=:medium)
    variant = { medium: { resize: "300x300" }, thumb: { resize: "100x100" } }
    user.cover_photo.attached? ? user.cover_photo : image_path("#{type}/sample_cover_photo.jpg")
  end

  def brand_logo_image(brand, type=:medium)
    variant = { medium: { resize: "300x300" }, thumb: { resize: "100x100" } }
    brand.logo.attached? ? brand.logo.variant(variant[type]) : image_path("#{type}/brand_logo.png")
  end

  def brand_cover_photo(brand, type=:medium)
    variant = { medium: { resize: "300x300" }, thumb: { resize: "100x100" } }
    brand.cover_photo.attached? ? brand.cover_photo : image_path("#{type}/brand_image.jpg")
  end

  def user_profile_link(user)
    user.persisted? ? user_profile_path(user.handle) : ""
  end

  def brand_profile_link(brand)
    brand.persisted? ? brand_profile_path(brand.handle) : ""
  end
end
