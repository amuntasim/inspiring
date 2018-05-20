class HomeController < ApplicationController
  def index
     render current_user ? :user_index : :index
  end
end
