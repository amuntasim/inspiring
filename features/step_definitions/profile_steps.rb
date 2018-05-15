# frozen_string_literal: true

Then "I can go and edit my profile" do
  HomePage.new.header.edit_profile
  @page = ProfileEditPage.new
  expect(@page.loaded?).to be_truthy, "Edit Profile page did not load properly"
end

Then "I can change the users name" do
  @page.update_name
  expect(User.last.full_name).to eq "Covfefe Covfefey"
end
