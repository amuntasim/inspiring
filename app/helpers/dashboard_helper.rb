module DashboardHelper

  def review_on_for_agent(review)
    if review.space
      link_to review.space.name, agent_dashboard_spaces_path(review.space)
    elsif review.property
      link_to review.property.name, agent_dashboard_properties_path(review.property)
    end
  end

  def review_on(review)
    if review.space
      link_to review.space.name, space_properties_path(id: review.property_id, space_id: review.space_id)
    elsif review.property
      link_to review.property.name, properties_path(review.property)
    end
  end
end
