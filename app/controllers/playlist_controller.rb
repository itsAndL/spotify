# app/controllers/playlist_controller.rb
class PlaylistController < ApplicationController
  def show
    @playlist = mock_playlist
    @lectures = mock_playlist_lectures
  end

  private

  def mock_playlist
    {
      id: params[:id],
      title: "دروس العقيدة السلفية",
      subtitle: "أهم دروس العقيدة الإسلامية الصحيحة",
      image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
      total_songs: 50,
      total_duration: "25 ساعة 30 دقيقة"
    }
  end

  def mock_playlist_lectures
    [
      {
        id: 1,
        title: "الوسائل المعينة على التفقه في دين الله",
        artist: "صالح آل الشيخ",
        album: "دروس العقيدة",
        duration: "45:20",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/06/%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B5%D8%A7%D9%84%D8%AD_%D8%A2%D9%84_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_2021.jpg",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "1,234,567"
      },
      {
        id: 2,
        title: "قصة ابن مسعود مع الذين كانوا يسبحون بالحصى",
        artist: "الشيخ محمد الألباني",
        album: "دروس في العقيدة",
        duration: "38:47",
        image: "https://pbs.twimg.com/profile_images/1411047963401633800/SHTTpJ-M_400x400.jpg",
        audio_url: "https://media.islamway.net/lessons/nasser/512_alalbany_ibnmasroudHassa.mp3",
        plays: "987,654"
      },
      {
        id: 3,
        title: "الرسول صلى الله عليه وسلم الرحمة المهداة للعالم كله",
        artist: "الشيخ عبد العزيز ابن باز",
        album: "دروس في العقيدة",
        duration: "52:21",
        image: "https://upload.wikimedia.org/wikipedia/ar/2/20/%D8%B5%D9%88%D8%B1%D8%A9_%D8%B4%D8%AE%D8%B5%D9%8A%D8%A9_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B9%D8%A8%D8%AF_%D8%A7%D9%84%D8%B9%D8%B2%D9%8A%D8%B2_%D8%A7%D8%A8%D9%86_%D8%A8%D8%A7%D8%B2.png",
        audio_url: "https://files.zadapps.info/binbaz.org.sa/sawtyaat/dros%26mohadrat/ta3lqat_%20jame3_kabeer/alrasol_almohda.mp3",
        plays: "876,543"
      },
      {
        id: 4,
        title: "أنواع التوحيد الثلاثة",
        artist: "الشيخ محمد العثيمين",
        album: "العقيدة الواسطية",
        duration: "41:36",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/06/%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B5%D8%A7%D9%84%D8%AD_%D8%A2%D9%84_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_2021.jpg",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%A5%D9%86%20%D8%A3%D9%87%D9%85%20%D8%A7%D9%84%D9%85%D9%87%D9%85%D8%A7%D8%AA%20%D9%87%D9%88%20%D8%A7%D9%84%D8%AA%D9%88%D8%AD%D9%8A%D8%AF%20%D8%8C%20%D9%81%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%83%D8%AA%D8%A8%20%D9%88%D8%A7%D9%84%D8%B4%D8%B1%D9%88%D8%AD%20%D9%88%D8%A7%D9%84%D8%A3%D8%B4%D8%B1%D8%B7%D8%A9%20%D8%A7%D9%84%D8%AA%D9%8A%20%D8%AA%D9%81%D9%8A%D8%AF%20%D9%81%D9%8A%20%D8%AA%D8%B9%D9%84%D9%85%20%D9%87%D8%B0%D8%A7%20%D8%A7%D9%84%D8%A3%D8%B5%D9%84%20%D8%A7%D9%84%D8%B9%D8%B8%D9%8A%D9%85%20%D8%9F.mp3",
        plays: "765,432"
      },
      {
        id: 5,
        title: "الشرك الأكبر والأصغر",
        artist: "الشيخ ربيع المدخلي",
        album: "منهج السلف",
        duration: "49:51",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/06/%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B5%D8%A7%D9%84%D8%AD_%D8%A2%D9%84_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_2021.jpg",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%A5%D9%86%20%D8%A3%D9%87%D9%85%20%D8%A7%D9%84%D9%85%D9%87%D9%85%D8%A7%D8%AA%20%D9%87%D9%88%20%D8%A7%D9%84%D8%AA%D9%88%D8%AD%D9%8A%D8%AF%20%D8%8C%20%D9%81%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%83%D8%AA%D8%A8%20%D9%88%D8%A7%D9%84%D8%B4%D8%B1%D9%88%D8%AD%20%D9%88%D8%A7%D9%84%D8%A3%D8%B4%D8%B1%D8%B7%D8%A9%20%D8%A7%D9%84%D8%AA%D9%8A%20%D8%AA%D9%81%D9%8A%D8%AF%20%D9%81%D9%8A%20%D8%AA%D8%B9%D9%84%D9%85%20%D9%87%D8%B0%D8%A7%20%D8%A7%D9%84%D8%A3%D8%B5%D9%84%20%D8%A7%D9%84%D8%B9%D8%B8%D9%8A%D9%85%20%D8%9F.mp3",
        plays: "654,321"
      }
    ]
  end
end
