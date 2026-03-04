# frozen_string_literal: true

class Layout::HeaderComponent < ViewComponent::Base
  def initialize
    @nav_items = [
      { name: "Home", path: "/" },
      { name: "Services", path: "/services" },
      { name: "Process", path: "/process" },
      { name: "Case Studies", path: "/case-studies" },
      { name: "About", path: "/about" }
    ]
  end

  attr_reader :nav_items
end
