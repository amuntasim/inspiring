class HomeController < ApplicationController
  def index
    fetch_stories
  end

  private

  def fetch_stories
    @stories = Story.order("created_at desc").page(params[:page]).per_page(10)
  end
end
