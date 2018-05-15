module Dashboard
  class ReviewsController < Dashboard::BaseController
    def index
      @reviews = scoped_items.paginate(:page => params[:page], per_page: 10).order('created_at DESC')
    end

    def create
      @review = Review.new(review_params)
      @review.user_id = current_user.id
      respond_to do |format|
        if @review.save
          format.js
        else
          format.js
        end
      end
    end

    private
    def review_params
      params.require(:review).permit(:rating, :comment,:property_id, :space_id)
    end

    def scoped_items
      Review.where(user_id: current_user.id)
    end
  end
end
