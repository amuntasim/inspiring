# frozen_string_literal: true

Then "I can see the signup page" do
  @page = SignupPage.new
  expect(@page.loaded?).to be_truthy, "Signup page did not load properly"
end

When "I click signup with no data" do
  @page.signup_button.click
end

When "I can see all the errors" do
  expect(@page.errors.count).to eq 4
end

When "I put the right data" do
  @page.signup
end
