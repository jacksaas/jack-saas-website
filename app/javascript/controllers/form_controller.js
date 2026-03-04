import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "error", "charCount", "submit"]

  validateField(event) {
    const field = event.target
    const fieldName = field.name
    const errorEl = this.errorTargets.find(el => el.dataset.field === fieldName)
    
    if (!errorEl) return

    let isValid = true
    let errorMessage = ""

    // Check validity
    if (field.hasAttribute("required") && !field.value.trim()) {
      isValid = false
      errorMessage = "This field is required"
    } else if (field.type === "email" && field.value) {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
      if (!emailRegex.test(field.value)) {
        isValid = false
        errorMessage = "Please enter a valid email address"
      }
    }

    // Show/hide error
    if (isValid) {
      errorEl.classList.add("hidden")
      field.classList.remove("border-red-500", "focus:ring-red-500")
      field.classList.add("border-slate-300", "focus:ring-blue-500")
    } else {
      errorEl.textContent = errorMessage
      errorEl.classList.remove("hidden")
      field.classList.remove("border-slate-300", "focus:ring-blue-500")
      field.classList.add("border-red-500", "focus:ring-red-500")
    }
  }

  updateCharCount(event) {
    const field = event.target
    const count = field.value.length
    this.charCountTarget.textContent = `${count} character${count !== 1 ? 's' : ''}`
  }
}
