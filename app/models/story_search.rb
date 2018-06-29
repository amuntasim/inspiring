class StorySearch
  def initialize(params)
    @params = params
  end

  def page
    @params[:page]
  end

  def user_id
    @params[:user_id]
  end

  def category_id
    @params[:category_id]
  end
end
