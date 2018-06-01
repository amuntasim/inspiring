class BrandsController < ApplicationController
  def home
    @brand = Brand.find_by_handle(params[:handle])
    @stories = Story.where(brand_id: @brand.id).order("created_at desc").page(params[:page]).per_page(10)
  end
end
