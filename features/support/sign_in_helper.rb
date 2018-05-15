# frozen_string_literal: true

Then "I login" do
  sign_in @user if @user
end

module SignInHelper
  def sign_in(user)
    page = LoginPage.new
    page.load
    page.login(user.email, "Abcd1234")
  end
end

World(SignInHelper)
