module AgentDashboard
  class BrandsController < AgentDashboard::BaseController
    before_action :set_brand, only: [:show, :edit, :update, :destroy]

    def index
      @brands = scoped_items.order('created_at DESC')
    end

    def new
      @brand = Story.new
    end

    def create
      @brand         = Story.new(brand_params)
      @brand.user_id = current_user.id
      respond_to do |format|
        if @brand.save
          format.html { redirect_to agent_dashboard_brand_url(@brand), notice: t('notifications.brand_created_successfully') }
          format.json { render :show, status: :created, location: @brand }
        else
          flash[:alert] = @brand.errors.full_messages
          format.html { render :new }
          format.json { render json: @brand.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @brand.update(brand_params)
          format.html { redirect_to agent_dashboard_brand_url(@brand), notice: t('notifications.brand_updated_successfully') }
          format.json { render :show, status: :ok, location: @brand }
        else
          flash[:alert] = @brand.errors.full_messages
          format.html { render :edit }
          format.json { render json: @brand.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @brand.destroy
      respond_to do |format|
        format.html { redirect_to agent_dashboard_brands_url, notice: 'Brand was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    def set_brand
      @brand= scoped_items.find(params[:id])
    end

    def brand_params
      params.require(:brand).permit(:name, :category_id, :description,
                                    :address, :latitude, :longitude, :phone, :web, :email,
                                    :logo, :cover_photo, tag_ids: [])
    end

    def scoped_items
      Story.where(user_id: current_user.id)
    end
  end
end
