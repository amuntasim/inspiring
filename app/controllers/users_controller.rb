class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def home
    @user    = User.find_by_handle(params[:handle])
    @stories = Story.where(user_id: @user.id).order("created_at desc").page(params[:page]).per_page(10)
  end

  def varify_handle
    user = User.new(handle: params[:handle])
    user.valid?
    @handle_error = user.errors[:handle].join(",") if user.errors[:handle].any?
  end
end
