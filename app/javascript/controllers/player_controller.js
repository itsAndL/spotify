// app/javascript/controllers/player_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "audio", "playButton", "playIcon", "pauseIcon", 
    "mobilePlayButton", "mobilePlayIcon", "mobilePauseIcon",
    "songTitle", "artistName", "albumCover", "albumImage", 
    "progress", "progressBar", "currentTime", "totalTime",
    "volumeProgress", "volumeBar", "volumeIcon", "volumeMuteIcon",
    "shuffleButton", "repeatButton", "repeatIcon", "repeatOneIcon",
    "likeButton", "previousButton", "nextButton"
  ]
  static values = { 
    currentTime: Number, 
    duration: Number,
    currentSongId: String
  }

  connect() {
    // Initialize state
    this.isPlaying = false
    this.currentSong = null
    this.playlist = []
    this.currentIndex = 0
    this.volume = 0.8
    this.isMuted = false
    this.isShuffleOn = false
    this.repeatMode = 0 // 0: off, 1: all, 2: one
    this.isInitialized = false
    
    // Prevent multiple instances
    if (window.spotifyPlayer && window.spotifyPlayer !== this) {
      // Clean up old instance
      window.spotifyPlayer.disconnect()
    }
    
    // Store reference globally
    window.spotifyPlayer = this

    // Restore state from localStorage (not sessionStorage for better persistence)
    this.restorePlayerState()
    
    // Set up audio
    this.setupAudio()
    
    // Listen for events
    this.setupEventListeners()
    
    // Mark as initialized
    this.isInitialized = true
  }

  disconnect() {
    // Save state before disconnecting
    this.savePlayerState()
    
    // Remove event listeners
    this.removeEventListeners()
    
    // Clear global reference if it's this instance
    if (window.spotifyPlayer === this) {
      window.spotifyPlayer = null
    }
  }

  setupAudio() {
    // Ensure we only have one audio element
    if (!this.audioTarget) return
    
    this.audioTarget.volume = this.volume
    this.updateVolumeDisplay()
    
    // Audio event listeners
    this.audioTarget.addEventListener('timeupdate', this.updateProgress.bind(this))
    this.audioTarget.addEventListener('loadedmetadata', this.updateDuration.bind(this))
    this.audioTarget.addEventListener('ended', this.handleSongEnd.bind(this))
    this.audioTarget.addEventListener('play', this.handleAudioPlay.bind(this))
    this.audioTarget.addEventListener('pause', this.handleAudioPause.bind(this))
    this.audioTarget.addEventListener('loadstart', this.handleLoadStart.bind(this))
    this.audioTarget.addEventListener('canplaythrough', this.handleCanPlayThrough.bind(this))
    this.audioTarget.addEventListener('error', this.handleError.bind(this))
  }

  setupEventListeners() {
    // Custom events
    this.playSongHandler = this.handlePlaySong.bind(this)
    this.setPlaylistHandler = this.handleSetPlaylist.bind(this)
    this.keydownHandler = this.handleKeydown.bind(this)
    
    document.addEventListener('play-song', this.playSongHandler)
    document.addEventListener('set-playlist', this.setPlaylistHandler)
    document.addEventListener('keydown', this.keydownHandler)
  }

  removeEventListeners() {
    if (this.playSongHandler) {
      document.removeEventListener('play-song', this.playSongHandler)
    }
    if (this.setPlaylistHandler) {
      document.removeEventListener('set-playlist', this.setPlaylistHandler)
    }
    if (this.keydownHandler) {
      document.removeEventListener('keydown', this.keydownHandler)
    }
  }

  handleKeydown(event) {
    if (this.isInputFocused()) return

    switch(event.code) {
      case 'Space':
        event.preventDefault()
        this.togglePlay()
        break
      case 'ArrowLeft':
        event.preventDefault()
        this.previousTrack()
        break
      case 'ArrowRight':
        event.preventDefault()
        this.nextTrack()
        break
      case 'ArrowUp':
        event.preventDefault()
        this.changeVolumeByAmount(0.1)
        break
      case 'ArrowDown':
        event.preventDefault()
        this.changeVolumeByAmount(-0.1)
        break
    }
  }

  isInputFocused() {
    const activeElement = document.activeElement
    return activeElement && (
      activeElement.tagName === 'INPUT' ||
      activeElement.tagName === 'TEXTAREA' ||
      activeElement.isContentEditable
    )
  }

  handlePlaySong(event) {
    const { id, title, artist, image, audioUrl, playlist } = event.detail
    
    console.log('handlePlaySong called with:', { id, title, artist, image, audioUrl, playlist })
    
    // Prevent playing the same song multiple times
    if (this.currentSong && String(this.currentSong.id) === String(id) && this.isPlaying) {
      console.log('Song already playing, ignoring')
      return
    }
    
    if (playlist && playlist.length > 0) {
      this.playlist = playlist
      
      // Find the correct index - ensure both IDs are strings for comparison
      this.currentIndex = playlist.findIndex(song => String(song.id) === String(id))
      
      console.log('Looking for song ID:', String(id))
      console.log('Playlist IDs:', playlist.map(s => String(s.id)))
      console.log('Found index:', this.currentIndex)
      
      if (this.currentIndex === -1) {
        console.warn('Song not found in playlist, defaulting to first song')
        this.currentIndex = 0
      }
    } else {
      // Single song - create a playlist with just this song
      const singleSong = { 
        id: String(id), 
        title, 
        artist, 
        image, 
        audioUrl 
      }
      this.playlist = [singleSong]
      this.currentIndex = 0
      console.log('Created single-song playlist:', this.playlist)
    }
    
    console.log('Playing song at index:', this.currentIndex, this.playlist[this.currentIndex])
    this.playSong(this.playlist[this.currentIndex])
  }

  handleSetPlaylist(event) {
    this.playlist = event.detail.playlist || []
  }

  playSong(song) {
    if (!song || !song.audioUrl) return

    // Stop current playback first
    this.audioTarget.pause()
    
    this.currentSong = song
    this.currentSongIdValue = song.id
    
    // Update UI
    this.updateSongInfo(song)
    
    // Load and play audio
    this.audioTarget.src = song.audioUrl
    this.audioTarget.load()
    
    // Play with promise handling
    const playPromise = this.audioTarget.play()
    
    if (playPromise !== undefined) {
      playPromise.catch(error => {
        console.error('Error playing audio:', error)
        this.isPlaying = false
        this.updatePlayButtons()
      })
    }

    this.savePlayerState()
  }

  updateSongInfo(song) {
    if (this.hasSongTitleTarget) {
      this.songTitleTarget.textContent = song.title
    }
    if (this.hasArtistNameTarget) {
      this.artistNameTarget.textContent = song.artist
    }
    if (this.hasAlbumImageTarget) {
      this.albumImageTarget.src = song.image
      this.albumImageTarget.alt = song.title
      this.albumImageTarget.classList.remove('hidden')
    }
    
    // Update document title
    document.title = `${song.title} • ${song.artist} - Spotify`
    
    // Dispatch event for mobile player
    this.dispatch('song-changed', { detail: song })
  }

  togglePlay() {
    if (!this.currentSong) {
      if (this.playlist.length > 0) {
        this.playSong(this.playlist[0])
      }
      return
    }

    if (this.audioTarget.paused) {
      this.audioTarget.play().catch(error => {
        console.error('Error playing audio:', error)
      })
    } else {
      this.audioTarget.pause()
    }
  }

  handleAudioPlay() {
    this.isPlaying = true
    this.updatePlayButtons()
    this.setupMediaSession()
  }

  handleAudioPause() {
    this.isPlaying = false
    this.updatePlayButtons()
  }

  setupMediaSession() {
    if ('mediaSession' in navigator && this.currentSong) {
      navigator.mediaSession.metadata = new MediaMetadata({
        title: this.currentSong.title,
        artist: this.currentSong.artist,
        artwork: [{ src: this.currentSong.image, sizes: '512x512', type: 'image/jpeg' }]
      })

      navigator.mediaSession.setActionHandler('play', () => this.togglePlay())
      navigator.mediaSession.setActionHandler('pause', () => this.togglePlay())
      navigator.mediaSession.setActionHandler('previoustrack', () => this.previousTrack())
      navigator.mediaSession.setActionHandler('nexttrack', () => this.nextTrack())
    }
  }

  handleLoadStart() {
    if (this.hasPlayButtonTarget) {
      this.playButtonTarget.classList.add('opacity-50')
    }
  }

  handleCanPlayThrough() {
    if (this.hasPlayButtonTarget) {
      this.playButtonTarget.classList.remove('opacity-50')
    }
  }

  handleError(event) {
    console.error('Audio error:', event)
    if (this.playlist.length > 1) {
      this.nextTrack()
    }
  }

  updatePlayButtons() {
    // Desktop buttons
    if (this.hasPlayIconTarget && this.hasPauseIconTarget) {
      this.playIconTarget.classList.toggle('hidden', this.isPlaying)
      this.pauseIconTarget.classList.toggle('hidden', !this.isPlaying)
    }
    
    // Mobile buttons
    if (this.hasMobilePlayIconTarget && this.hasMobilePauseIconTarget) {
      this.mobilePlayIconTarget.classList.toggle('hidden', this.isPlaying)
      this.mobilePauseIconTarget.classList.toggle('hidden', !this.isPlaying)
    }

    // Update all song items
    this.updateSongItemStates()
  }

  updateSongItemStates() {
    document.querySelectorAll('[data-song-id]').forEach(element => {
      const songId = element.dataset.songId
      const isCurrentSong = songId === this.currentSongIdValue
      const playIcon = element.querySelector('.play-icon')
      const pauseIcon = element.querySelector('.pause-icon')
      const trackNumber = element.querySelector('.track-number')
      
      if (isCurrentSong && this.isPlaying) {
        // Show pause icon for current playing song
        if (trackNumber) trackNumber.classList.add('hidden')
        if (playIcon) playIcon.classList.add('hidden')
        if (pauseIcon) pauseIcon.classList.remove('hidden')
      } else if (isCurrentSong && !this.isPlaying) {
        // Show play icon for current paused song
        if (trackNumber) trackNumber.classList.add('hidden')
        if (playIcon) playIcon.classList.remove('hidden')
        if (pauseIcon) pauseIcon.classList.add('hidden')
      } else {
        // Show track number for other songs
        if (trackNumber) trackNumber.classList.remove('hidden')
        if (playIcon) playIcon.classList.add('hidden')
        if (pauseIcon) pauseIcon.classList.add('hidden')
      }
    })

    // Update big play button in playlists
    const bigPlayButtons = document.querySelectorAll('[data-playlist-play]')
    bigPlayButtons.forEach(button => {
      const playIcon = button.querySelector('.play-icon')
      const pauseIcon = button.querySelector('.pause-icon')
      
      if (this.isPlaying && this.playlist.length > 0) {
        if (playIcon) playIcon.classList.add('hidden')
        if (pauseIcon) pauseIcon.classList.remove('hidden')
      } else {
        if (playIcon) playIcon.classList.remove('hidden')
        if (pauseIcon) pauseIcon.classList.add('hidden')
      }
    })
  }

  updateProgress() {
    if (!this.audioTarget || !this.hasProgressTarget) return
    
    const currentTime = this.audioTarget.currentTime
    const duration = this.audioTarget.duration

    if (duration > 0) {
      const progressPercent = (currentTime / duration) * 100
      this.progressTarget.style.width = `${progressPercent}%`
      
      if (this.hasCurrentTimeTarget) {
        this.currentTimeTarget.textContent = this.formatTime(currentTime)
      }
      
      // Update media session position
      if ('mediaSession' in navigator && navigator.mediaSession.setPositionState) {
        try {
          navigator.mediaSession.setPositionState({
            duration: duration,
            playbackRate: this.audioTarget.playbackRate,
            position: currentTime
          })
        } catch (error) {
          // Ignore errors from media session
        }
      }
    }
  }

  updateDuration() {
    if (!this.audioTarget || !this.hasTotalTimeTarget) return
    
    const duration = this.audioTarget.duration
    if (!isNaN(duration)) {
      this.totalTimeTarget.textContent = this.formatTime(duration)
    }
  }

  seek(event) {
    if (!this.audioTarget.duration) return

    const rect = this.progressBarTarget.getBoundingClientRect()
    const clickX = event.clientX - rect.left
    const width = rect.width
    const percentage = Math.max(0, Math.min(1, clickX / width))
    const newTime = percentage * this.audioTarget.duration

    this.audioTarget.currentTime = newTime
  }

  previousTrack() {
    if (!this.playlist.length) return

    // If more than 3 seconds into the song, restart it
    if (this.audioTarget.currentTime > 3) {
      this.audioTarget.currentTime = 0
      return
    }

    // Otherwise go to previous track
    if (this.isShuffleOn) {
      // For shuffle, pick a random different song
      let newIndex = Math.floor(Math.random() * this.playlist.length)
      while (newIndex === this.currentIndex && this.playlist.length > 1) {
        newIndex = Math.floor(Math.random() * this.playlist.length)
      }
      this.currentIndex = newIndex
    } else {
      this.currentIndex = this.currentIndex > 0 ? this.currentIndex - 1 : this.playlist.length - 1
    }
    
    this.playSong(this.playlist[this.currentIndex])
  }

  nextTrack() {
    if (!this.playlist.length) return

    if (this.isShuffleOn) {
      // For shuffle, pick a random different song
      let newIndex = Math.floor(Math.random() * this.playlist.length)
      while (newIndex === this.currentIndex && this.playlist.length > 1) {
        newIndex = Math.floor(Math.random() * this.playlist.length)
      }
      this.currentIndex = newIndex
    } else {
      this.currentIndex = (this.currentIndex + 1) % this.playlist.length
    }
    
    this.playSong(this.playlist[this.currentIndex])
  }

  toggleShuffle() {
    this.isShuffleOn = !this.isShuffleOn
    
    if (this.hasShuffleButtonTarget) {
      this.shuffleButtonTarget.classList.toggle('text-green-500', this.isShuffleOn)
      this.shuffleButtonTarget.classList.toggle('text-gray-400', !this.isShuffleOn)
    }
    
    this.savePlayerState()
  }

  toggleRepeat() {
    // Cycle through: off (0) -> all (1) -> one (2) -> off (0)
    this.repeatMode = (this.repeatMode + 1) % 3
    
    this.updateRepeatButton()
    this.savePlayerState()
  }

  updateRepeatButton() {
    if (!this.hasRepeatButtonTarget) return
    
    // Update button color
    this.repeatButtonTarget.classList.toggle('text-green-500', this.repeatMode > 0)
    this.repeatButtonTarget.classList.toggle('text-gray-400', this.repeatMode === 0)
    
    // Update icon
    if (this.hasRepeatIconTarget && this.hasRepeatOneIconTarget) {
      if (this.repeatMode === 2) {
        // Show repeat one icon
        this.repeatIconTarget.classList.add('hidden')
        this.repeatOneIconTarget.classList.remove('hidden')
      } else {
        // Show regular repeat icon
        this.repeatIconTarget.classList.remove('hidden')
        this.repeatOneIconTarget.classList.add('hidden')
      }
    }
  }

  toggleMute() {
    this.isMuted = !this.isMuted
    this.audioTarget.muted = this.isMuted
    this.updateVolumeDisplay()
    this.updateVolumeIcon()
    this.savePlayerState()
  }

  updateVolumeIcon() {
    if (!this.hasVolumeIconTarget || !this.hasVolumeMuteIconTarget) return
    
    if (this.isMuted || this.volume === 0) {
      this.volumeIconTarget.classList.add('hidden')
      this.volumeMuteIconTarget.classList.remove('hidden')
    } else {
      this.volumeIconTarget.classList.remove('hidden')
      this.volumeMuteIconTarget.classList.add('hidden')
    }
  }

  changeVolume(event) {
    const rect = this.volumeBarTarget.getBoundingClientRect()
    const clickX = event.clientX - rect.left
    const width = rect.width
    const newVolume = Math.max(0, Math.min(1, clickX / width))

    this.volume = newVolume
    this.audioTarget.volume = this.volume
    this.isMuted = false
    this.audioTarget.muted = false
    this.updateVolumeDisplay()
    this.updateVolumeIcon()
    this.savePlayerState()
  }

  changeVolumeByAmount(amount) {
    this.volume = Math.max(0, Math.min(1, this.volume + amount))
    this.audioTarget.volume = this.volume
    this.isMuted = false
    this.audioTarget.muted = false
    this.updateVolumeDisplay()
    this.updateVolumeIcon()
    this.savePlayerState()
  }

  updateVolumeDisplay() {
    const volumePercent = this.isMuted ? 0 : this.volume * 100
    if (this.hasVolumeProgressTarget) {
      this.volumeProgressTarget.style.width = `${volumePercent}%`
    }
  }

  handleSongEnd() {
    if (this.repeatMode === 2) {
      // Repeat one - restart current song
      this.audioTarget.currentTime = 0
      this.audioTarget.play()
    } else if (this.currentIndex < this.playlist.length - 1) {
      // Not at end of playlist - play next
      this.nextTrack()
    } else if (this.repeatMode === 1) {
      // At end of playlist with repeat all - go to first song
      this.currentIndex = 0
      this.playSong(this.playlist[0])
    } else {
      // End of playlist, no repeat
      this.isPlaying = false
      this.updatePlayButtons()
    }
  }

  toggleLike() {
    if (!this.currentSong) return
    
    if (this.hasLikeButtonTarget) {
      this.likeButtonTarget.classList.toggle('text-green-500')
      this.likeButtonTarget.classList.toggle('text-gray-400')
    }
  }

  openMobilePlayer() {
    if (!this.currentSong) return
    
    const event = new CustomEvent('open-mobile-player', {
      detail: { song: this.currentSong }
    })
    document.dispatchEvent(event)
  }

  savePlayerState() {
    if (!this.currentSong || !this.isInitialized) return

    const state = {
      currentSong: this.currentSong,
      playlist: this.playlist,
      currentIndex: this.currentIndex,
      currentTime: this.audioTarget.currentTime,
      volume: this.volume,
      isMuted: this.isMuted,
      isShuffleOn: this.isShuffleOn,
      repeatMode: this.repeatMode,
      isPlaying: this.isPlaying
    }
    
    localStorage.setItem('spotify-player-state', JSON.stringify(state))
  }

  restorePlayerState() {
    const savedState = localStorage.getItem('spotify-player-state')
    if (!savedState) return

    try {
      const state = JSON.parse(savedState)
      
      this.currentSong = state.currentSong
      this.playlist = state.playlist || []
      this.currentIndex = state.currentIndex || 0
      this.volume = state.volume !== undefined ? state.volume : 0.8
      this.isMuted = state.isMuted || false
      this.isShuffleOn = state.isShuffleOn || false
      this.repeatMode = state.repeatMode || 0
      
      if (this.currentSong) {
        this.currentSongIdValue = this.currentSong.id
        this.updateSongInfo(this.currentSong)
        
        this.audioTarget.src = this.currentSong.audioUrl
        this.audioTarget.currentTime = state.currentTime || 0
        
        // Don't auto-play on page load
        this.audioTarget.load()
      }
      
      this.audioTarget.volume = this.volume
      this.audioTarget.muted = this.isMuted
      this.updateVolumeDisplay()
      this.updateVolumeIcon()
      this.updateRepeatButton()
      this.updatePlayButtons()
      
      // Update shuffle button
      if (this.hasShuffleButtonTarget) {
        this.shuffleButtonTarget.classList.toggle('text-green-500', this.isShuffleOn)
        this.shuffleButtonTarget.classList.toggle('text-gray-400', !this.isShuffleOn)
      }
      
    } catch (error) {
      console.error('Error restoring player state:', error)
      localStorage.removeItem('spotify-player-state')
    }
  }

  formatTime(seconds) {
    if (isNaN(seconds)) return '0:00'
    
    const mins = Math.floor(seconds / 60)
    const secs = Math.floor(seconds % 60)
    return `${mins}:${secs.toString().padStart(2, '0')}`
  }
}