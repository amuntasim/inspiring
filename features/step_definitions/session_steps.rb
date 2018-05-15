# frozen_string_literal: true

Given "There is a user" do
  @user = FactoryBot.create(:user, confirmed_at: Time.now)

end

When "I go to the login path" do
  @page = LoginPage.new
  @page.load
  expect(@page.loaded?).to be_truthy, "Login Page was not loaded properly"
end

And "I login with this user" do
  @page.login(@user.email)
end

Then "I am on the home page logged in" do
  @page = HomePage.new
  expect(@page.loaded?).to be_truthy, "Home Page was not loaded properly"
end

When "I logout" do
  @page.header.logout
end

Then "I am back to the login page" do
  @page = LoginPage.new
  expect(@page.loaded?).to be_truthy, "Login Page was not loaded properly"
end
