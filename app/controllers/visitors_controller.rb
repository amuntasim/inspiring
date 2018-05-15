class VisitorsController < ApplicationController
  def index
    @header_classes = ''
    @categories = Category.for("property").includes(:translations).order("items_count DESC")
  end
end
