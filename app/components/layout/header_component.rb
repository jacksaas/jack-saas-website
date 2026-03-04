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

  def active_class(path)
    return "text-blue-600 bg-blue-50" if path == "/" && request.path == "/"
    return "text-blue-600 bg-blue-50" if path != "/" && request.path.start_with?(path)
    "text-slate-600 hover:text-blue-600 hover:bg-slate-50"
  end
end
