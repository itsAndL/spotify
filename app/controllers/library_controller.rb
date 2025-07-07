# app/controllers/library_controller.rb
class LibraryController < ApplicationController
  def index
    @library_items = mock_library_items
  end

  private

  def mock_library_items
    [
      { id: 1, title: "المحاضرات المفضلة", subtitle: "749 محاضرة", image: "https://misc.scdn.co/liked-songs/liked-songs-640.png", type: "playlist" },
      { id: 2, title: "قائمة تشغيلي #1", subtitle: "12 محاضرة", image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228", type: "playlist" },
      { id: 3, title: "المشغل مؤخراً", subtitle: "منشأة تلقائياً", image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228", type: "playlist" }
    ]
  end
end
