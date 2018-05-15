# frozen_string_literal: true

When(/^I click link "(.*?)"$/) do |link|
  click_link(link)
end

When(/^I click button "(.*?)"$/) do |link|
  click_button(link)
end

When(/^I click on "(.*?)"$/) do |item|
  page.find(item).click
end

When(/^I hover on "(.*?)"$/) do |selector|
  page.find(selector).hover
end

When(/^I reload the page$/) do
  page.evaluate_script("window.location.reload()")
end

When(/^I click on selector "(.*?)"$/) do |selector|
  find(selector, visible: false).click
end

When(/^I click on hidden "(.*?)" and confirm$/) do |selector|
  Capybara.ignore_hidden_elements = false
  page.accept_confirm do
    find(selector).click
  end
  Capybara.ignore_hidden_elements = true

end
When(/^I click on "(.*?)" and confirm$/) do |link|
  page.accept_confirm do
    click_link link
  end
end

When /^I go to the user dashboard$/ do
  visit :dashboard
  #save_and_open_screenshot
end
