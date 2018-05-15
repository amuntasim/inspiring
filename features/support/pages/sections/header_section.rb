# frozen_string_literal: true

class HeaderSection < SitePrism::Section
  element :nav_bar, ".nav.navbar-nav.navbar-right.user-menu.pull-right"
  element :user_name, "div.header > ul > li > a > span:nth-child(2)"
  element :user_menu, "a.dropdown-toggle.user-link"
  element :logout_link, "a.logout-link"
  element :edit_profile_link, "a.edit-profile-link"

  def load_validation
    has_nav_bar? &&
    has_user_menu? &&
    has_user_name?
  end

  def logout
    user_menu.click
    logout_link.click
  end

  def edit_profile
    user_menu.click
    edit_profile_link.click
  end
end
