// app/javascript/application.js
import "@hotwired/turbo-rails"
import "./controllers"

// Prevent default drag behavior for better UX
document.addEventListener('dragstart', (e) => {
  if (e.target.tagName === 'IMG') {
    e.preventDefault()
  }
})

// Add touch support for mobile
document.addEventListener('touchstart', () => {}, { passive: true })

// Handle mobile viewport height for better player experience
function setVH() {
  let vh = window.innerHeight * 0.01
  document.documentElement.style.setProperty('--vh', `${vh}px`)
}

setVH()
window.addEventListener('resize', setVH)
window.addEventListener('orientationchange', setVH)