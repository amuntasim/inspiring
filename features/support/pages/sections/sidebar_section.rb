# frozen_string_literal: true

class SidebarSection < SitePrism::Section
  element :procedures_link, "a.procedures-link"


  def click_procedures_link
    procedures_link.click
  end
end
