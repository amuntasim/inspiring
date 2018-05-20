module StoriesHelper
  def  review_counts(brand)
  "<span>(</span><span>#{t('count.review', count: brand.reviews_count)}</span><span>)</span>".html_safe
  end
end
