// app/javascript/controllers/app_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Global app initialization
    this.setupKeyboardShortcuts()
  }

  setupKeyboardShortcuts() {
    document.addEventListener('keydown', (event) => {
      // Space bar to play/pause
      if (event.code === 'Space' && !this.isInputFocused()) {
        event.preventDefault()
        const playButton = document.querySelector('[data-player-target="playButton"]')
        if (playButton) {
          playButton.click()
        }
      }
    })
  }

  isInputFocused() {
    const activeElement = document.activeElement
    return activeElement && (
      activeElement.tagName === 'INPUT' ||
      activeElement.tagName === 'TEXTAREA' ||
      activeElement.isContentEditable
    )
  }
}