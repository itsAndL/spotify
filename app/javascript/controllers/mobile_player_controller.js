// app/javascript/controllers/mobile_player_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "modal", "songTitle", "artistName", "albumImage", 
    "progress", "progressBar", "currentTime", "totalTime", 
    "playButton", "playIcon", "pauseIcon", "likeButton",
    "shuffleButton", "repeatButton", "repeatIcon", "repeatOneIcon"
  ]

  connect() {
    this.setupEventListeners()
    this.findPlayerController()
  }

  disconnect() {
    this.removeEventListeners()
  }

  setupEventListeners() {
    this.openHandler = this.open.bind(this)
    this.songChangedHandler = this.updateSong.bind(this)
    this.timeUpdateHandler = this.updateProgress.bind(this)
    this.loadedMetadataHandler = this.updateDuration.bind(this)
    this.playHandler = this.updatePlayButton.bind(this)
    this.pauseHandler = this.updatePlayButton.bind(this)
    
    document.addEventListener('open-mobile-player', this.openHandler)
    document.addEventListener('player:song-changed', this.songChangedHandler)
    
    this.audioElement = document.querySelector('[data-player-target="audio"]')
    if (this.audioElement) {
      this.audioElement.addEventListener('timeupdate', this.timeUpdateHandler)
      this.audioElement.addEventListener('loadedmetadata', this.loadedMetadataHandler)
      this.audioElement.addEventListener('play', this.playHandler)
      this.audioElement.addEventListener('pause', this.pauseHandler)
    }
  }

  removeEventListeners() {
    document.removeEventListener('open-mobile-player', this.openHandler)
    document.removeEventListener('player:song-changed', this.songChangedHandler)
    
    if (this.audioElement) {
      this.audioElement.removeEventListener('timeupdate', this.timeUpdateHandler)
      this.audioElement.removeEventListener('loadedmetadata', this.loadedMetadataHandler)
      this.audioElement.removeEventListener('play', this.playHandler)
      this.audioElement.removeEventListener('pause', this.pauseHandler)
    }
  }

  findPlayerController() {
    // Use the global reference
    this.playerController = window.spotifyPlayer
  }

  open(event) {
    const { song } = event.detail
    this.updateSong({ detail: song })
    this.modalTarget.classList.remove('hidden')
    document.body.style.overflow = 'hidden'
    
    // Update button states
    this.updatePlayButton()
    this.updateControlStates()
  }

  close() {
    this.modalTarget.classList.add('hidden')
    document.body.style.overflow = ''
  }

  updateSong(event) {
    const song = event.detail
    
    if (this.hasSongTitleTarget) {
      this.songTitleTarget.textContent = song.title
    }
    if (this.hasArtistNameTarget) {
      this.artistNameTarget.textContent = song.artist
    }
    if (this.hasAlbumImageTarget) {
      this.albumImageTarget.src = song.image
      this.albumImageTarget.alt = song.title
    }
  }

  updateProgress() {
    if (!this.audioElement || !this.hasProgressTarget || !this.hasCurrentTimeTarget) return
    
    const currentTime = this.audioElement.currentTime
    const duration = this.audioElement.duration

    if (duration > 0) {
      const progressPercent = (currentTime / duration) * 100
      this.progressTarget.style.width = `${progressPercent}%`
      this.currentTimeTarget.textContent = this.formatTime(currentTime)
    }
  }

  updateDuration() {
    if (!this.audioElement || !this.hasTotalTimeTarget) return
    
    const duration = this.audioElement.duration
    if (!isNaN(duration)) {
      this.totalTimeTarget.textContent = this.formatTime(duration)
    }
  }

  updatePlayButton() {
    if (!this.audioElement || !this.hasPlayIconTarget || !this.hasPauseIconTarget) return
    
    const isPlaying = !this.audioElement.paused
    this.playIconTarget.classList.toggle('hidden', isPlaying)
    this.pauseIconTarget.classList.toggle('hidden', !isPlaying)
  }

  updateControlStates() {
    if (!this.playerController) {
      this.findPlayerController()
    }
    
    if (!this.playerController) return
    
    // Update shuffle button
    if (this.hasShuffleButtonTarget) {
      this.shuffleButtonTarget.classList.toggle('text-green-500', this.playerController.isShuffleOn)
      this.shuffleButtonTarget.classList.toggle('text-gray-400', !this.playerController.isShuffleOn)
    }
    
    // Update repeat button
    if (this.hasRepeatButtonTarget) {
      this.repeatButtonTarget.classList.toggle('text-green-500', this.playerController.repeatMode > 0)
      this.repeatButtonTarget.classList.toggle('text-gray-400', this.playerController.repeatMode === 0)
      
      if (this.hasRepeatIconTarget && this.hasRepeatOneIconTarget) {
        if (this.playerController.repeatMode === 2) {
          this.repeatIconTarget.classList.add('hidden')
          this.repeatOneIconTarget.classList.remove('hidden')
        } else {
          this.repeatIconTarget.classList.remove('hidden')
          this.repeatOneIconTarget.classList.add('hidden')
        }
      }
    }
    
    // Update like button
    if (this.hasLikeButtonTarget) {
      // Check if current song is liked (you can implement this logic)
      // this.likeButtonTarget.classList.toggle('text-green-500', isLiked)
    }
  }

  togglePlay() {
    if (this.playerController) {
      this.playerController.togglePlay()
    }
  }

  toggleLike() {
    if (this.playerController) {
      this.playerController.toggleLike()
    }
  }

  toggleShuffle() {
    if (this.playerController) {
      this.playerController.toggleShuffle()
      this.updateControlStates()
    }
  }

  toggleRepeat() {
    if (this.playerController) {
      this.playerController.toggleRepeat()
      this.updateControlStates()
    }
  }

  previousTrack() {
    if (this.playerController) {
      this.playerController.previousTrack()
    }
  }

  nextTrack() {
    if (this.playerController) {
      this.playerController.nextTrack()
    }
  }

  seek(event) {
    if (!this.audioElement || !this.audioElement.duration) return

    const rect = this.progressBarTarget.getBoundingClientRect()
    const clickX = event.clientX - rect.left
    const width = rect.width
    const percentage = Math.max(0, Math.min(1, clickX / width))
    const newTime = percentage * this.audioElement.duration

    this.audioElement.currentTime = newTime
  }

  formatTime(seconds) {
    if (isNaN(seconds)) return '0:00'
    
    const mins = Math.floor(seconds / 60)
    const secs = Math.floor(seconds % 60)
    return `${mins}:${secs.toString().padStart(2, '0')}`
  }
}