module Dashboard
  class InspirationsController < Dashboard::BaseController
    def index
      @inspirations = scoped_items.paginate(:page => params[:page], per_page: 10).order('created_at DESC')
    end

    def create
      @inspiration = Inspiration.create_or_destroy!(params[:property_id], current_user.id)
    end

    private

    def scoped_items
      Inspiration.where(user_id: current_user.id)
    end
  end
end
