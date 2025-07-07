// app/javascript/controllers/scroll_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('scroll', this.handleScroll.bind(this))
  }

  disconnect() {
    this.element.removeEventListener('scroll', this.handleScroll.bind(this))
  }

  handleScroll() {
    // Add scroll-based effects like changing header opacity
    const scrollTop = this.element.scrollTop
    const header = this.element.querySelector('h1, h2')
    
    if (header) {
      const opacity = Math.max(0.1, 1 - (scrollTop / 200))
      header.style.opacity = opacity
    }
  }
}