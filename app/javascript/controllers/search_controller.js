// app/javascript/controllers/search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  static values = { url: String }

  search() {
    const query = this.inputTarget.value
    if (query.length > 0) {
      const url = new URL(this.urlValue, window.location.origin)
      url.searchParams.set('q', query)
      
      // Use Turbo to navigate
      Turbo.visit(url.toString())
    }
  }
}