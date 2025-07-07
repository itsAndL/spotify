# app/controllers/search_controller.rb
class SearchController < ApplicationController
  def index
    @browse_categories = mock_browse_categories
    @search_results = params[:q].present? ? mock_search_results : []
  end

  private

  def mock_browse_categories
    [
      { id: 1, name: "العقيدة", color: "bg-pink-500", image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228" },
      { id: 2, name: "الفقه", color: "bg-orange-500", image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228" },
      { id: 3, name: "التفسير", color: "bg-red-500", image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228" },
      { id: 4, name: "الحديث", color: "bg-blue-500", image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228" }
    ]
  end

  def mock_search_results
    [
      {
        id: 1,
        title: "الوسائل المعينة على التفقه في دين الله",
        artist: "صالح آل الشيخ",
        album: "دروس العقيدة",
        duration: "45:20",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/06/%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B5%D8%A7%D9%84%D8%AD_%D8%A2%D9%84_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_2021.jpg",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3"
      },
      {
        id: 2,
        title: "الرسول صلى الله عليه وسلم الرحمة المهداة للعالم كله",
        artist: "الشيخ عبد العزيز ابن باز",
        album: "فقه العبادات",
        duration: "38:14",
        image: "https://upload.wikimedia.org/wikipedia/ar/2/20/%D8%B5%D9%88%D8%B1%D8%A9_%D8%B4%D8%AE%D8%B5%D9%8A%D8%A9_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B9%D8%A8%D8%AF_%D8%A7%D9%84%D8%B9%D8%B2%D9%8A%D8%B2_%D8%A7%D8%A8%D9%86_%D8%A8%D8%A7%D8%B2.png",
        audio_url: "https://files.zadapps.info/binbaz.org.sa/sawtyaat/dros%26mohadrat/ta3lqat_%20jame3_kabeer/alrasol_almohda.mp3"
      }
    ]
  end
end
