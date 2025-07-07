// app/javascript/controllers/song_item_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { 
    id: String, 
    title: String, 
    artist: String, 
    image: String, 
    audio: String 
  }

  connect() {
    this.element.dataset.songId = this.idValue
  }

  play() {
    // Get playlist context if available
    const playlistElement = this.element.closest('[data-playlist]')
    let playlist = null
    
    if (playlistElement && playlistElement.dataset.playlist) {
      try {
        // Parse the playlist data
        const playlistData = playlistElement.dataset.playlist
        playlist = JSON.parse(playlistData)
        
        // Ensure all songs have the correct structure and consistent IDs
        playlist = playlist.map(song => ({
          id: String(song.id), // Ensure ID is string for consistent comparison
          title: song.title,
          artist: song.artist,
          image: song.image,
          audioUrl: song.audioUrl || song.audio_url
        }))
        
        console.log('Parsed playlist:', playlist)
        console.log('Clicked song ID:', this.idValue)
      } catch (error) {
        console.error('Error parsing playlist data:', error)
        playlist = null
      }
    }

    // Create the song object with consistent ID format
    const songData = {
      id: String(this.idValue), // Ensure ID is string
      title: this.titleValue,
      artist: this.artistValue,
      image: this.imageValue,
      audioUrl: this.audioValue
    }

    const event = new CustomEvent('play-song', {
      detail: {
        ...songData,
        playlist: playlist
      }
    })
    
    console.log('Dispatching play-song event:', event.detail)
    document.dispatchEvent(event)
  }
}