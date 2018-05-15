# frozen_string_literal: true

Then("I can see {int} errors") do |count|
  expect(@page.errors.count).to eq count
end
