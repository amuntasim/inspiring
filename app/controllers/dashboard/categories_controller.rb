module Dashboard
  class CategoriesController < Dashboard::BaseController
    def index
      @categories = scoped_items.paginate(:page => params[:page], per_page: 10).order('created_at DESC')
    end

    def preferences
      if request.post?
        current_user.category_ids = params[:category_ids]
        current_user.save
        @success = true
      end
    end

    private
    def scoped_items
      current_user.categories
    end
  end
end
