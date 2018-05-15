module Admin
  class UsersController < Admin::ApplicationController

    before_action :check_if_password_provided, only: [:update]
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = User.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   User.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    protected

    def check_if_password_provided
      if params[:user][:password].blank?
        params[:user].delete(:password)
      end

    end
  end
end
