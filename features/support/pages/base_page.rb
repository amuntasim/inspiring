# frozen_string_literal: true

class BasePage < SitePrism::Page
  elements :errors, ".has_error"
end
