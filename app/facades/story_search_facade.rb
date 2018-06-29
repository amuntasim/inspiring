class StorySearchFacade
  attr_reader :search_params

  def initialize(search_params)
    @search = StorySearch.new(search_params)
  end

  def base_stories
    @base_stories ||= Story.where(prepare_filters)
  end

  def filtered_stories
    base_stories.includes(:user)
  end

  def stories
    filtered_stories.paginate(:page => @search.page, per_page: 10)
  end

  def prepare_filters
    filter = {}
    filter.merge!(user_id: @search.user_id) if @search.user_id.present?
    filter.merge!(category_id: @search.category_id) if @search.category_id.present?
    filter
  end
end
