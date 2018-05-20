module AgentDashboard
  class ReviewsController < AgentDashboard::BaseController
    def index
      @reviews = scoped_items.paginate(:page => params[:page], per_page: 10).order('created_at DESC')
    end

    private
    def scoped_items
      Review.where(brand_id: Story.manageable_brand_ids(current_user.id))
    end
  end
end
