# frozen_string_literal: true

require_relative "sections/header_section"
require_relative "sections/sidebar_section"

class HomePage < SitePrism::Page
  set_url "/"

  section :header, HeaderSection, "div.header"
  section :sidebar, SidebarSection, "div.sidebar"

  load_validation { [has_header?, "header section did not appear"] }
end
