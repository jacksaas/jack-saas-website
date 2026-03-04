import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mobileMenu", "menuButton", "openIcon", "closeIcon"]

  connect() {
    this.isOpen = false
  }

  toggleMenu() {
    if (this.isOpen) {
      this.closeMenu()
    } else {
      this.openMenu()
    }
  }

  openMenu() {
    this.isOpen = true
    this.mobileMenuTarget.classList.remove("hidden")
    this.openIconTarget.classList.add("hidden")
    this.closeIconTarget.classList.remove("hidden")
    this.menuButtonTarget.setAttribute("aria-expanded", "true")
    document.body.style.overflow = "hidden"
  }

  closeMenu() {
    this.isOpen = false
    this.mobileMenuTarget.classList.add("hidden")
    this.openIconTarget.classList.remove("hidden")
    this.closeIconTarget.classList.add("hidden")
    this.menuButtonTarget.setAttribute("aria-expanded", "false")
    document.body.style.overflow = ""
  }
}
