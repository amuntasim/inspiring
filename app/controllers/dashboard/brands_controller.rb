module Dashboard
  class BrandsController < Dashboard::BaseController
    before_action :set_brand, only: [:show, :edit, :update, :destroy]

    def index
      if current_user.brand_id
        redirect_to dashboard_brand_path(id: current_user.brand_id)
      end
    end

    def new
      @brand = Brand.new
    end

    def create
      @brand         = Brand.new(brand_params)
      respond_to do |format|
        if @brand.save
          current_user.update_column(:brand_id, @brand.id)
          format.html { redirect_to dashboard_brand_url(@brand), notice: 'Brand created successfully' }
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
          format.html { redirect_to dashboard_brand_url(@brand), notice: 'Brand updated successfully' }
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
        format.html { redirect_to dashboard_brands_url, notice: 'Brand was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    def set_brand
      @brand= Brand.find(current_user.brand_id)
    end

    def brand_params
      params.require(:brand).permit(:name, :category_id, :description,
                                    :address, :latitude, :longitude, :phone, :web, :email,
                                    :logo, :cover_photo, tag_ids: [])
    end
  end
end
