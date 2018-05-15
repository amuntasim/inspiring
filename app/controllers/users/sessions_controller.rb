class Users::SessionsController < Devise::SessionsController

  respond_to :html, :js

  # POST /resource/sign_in
  def create
    @user = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if @user.valid_password?(params[:user][:password])
      sign_in :user, @user
      @success = true
      return render nothing: true
    end

    invalid_login_attempt
  end

  protected

  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    @success = false
    render nothing: true
  end
end