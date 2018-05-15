module StoriesHelper

  def property_category_image(property)
    property.category.try(:icon) || 'im-icon-Home-2'
  end

  def  review_counts(property)
  "<span>(</span><span>#{t('count.review', count: property.reviews_count)}</span><span>)</span>".html_safe
  end
end
