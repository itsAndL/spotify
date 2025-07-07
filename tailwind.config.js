// tailwind.config.js
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        'arabic': ['Noto Sans Arabic', 'Tahoma', 'Arial', 'sans-serif'],
        'circular': ['Noto Sans Arabic', 'Tahoma', 'Arial', 'sans-serif'],
      },
      colors: {
        'spotify-green': '#1DB954',
        'spotify-black': '#191414',
        'spotify-gray': '#121212',
      },
      spacing: {
        'safe': 'env(safe-area-inset-bottom)',
      }
    },
  },
  plugins: [],
}