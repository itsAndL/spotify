# app/controllers/artist_controller.rb
class ArtistController < ApplicationController
  def show
    @artist = mock_artist
    @popular_lectures = mock_popular_lectures
    @albums = mock_artist_albums
    @appears_on = mock_appears_on
  end

  private

  def mock_artist
    {
      id: params[:id],
      name: "الشيخ صالح الفوزان",
      image: "https://upload.wikimedia.org/wikipedia/commons/1/1c/Saleh_Al-Fawzan.jpg",
      followers: "1,234,567",
      bio: "عالم وفقيه سعودي، عضو هيئة كبار العلماء، وعضو اللجنة الدائمة للإفتاء في المملكة العربية السعودية"
    }
  end

  def mock_popular_lectures
    [
      {
        id: 1,
        title: "أركان الإسلام الخمسة",
        album: "دروس في العقيدة",
        duration: "42:15",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/06/%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B5%D8%A7%D9%84%D8%AD_%D8%A2%D9%84_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_2021.jpg",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "2,345,678"
      },
      {
        id: 2,
        title: "شروط الصلاة وأركانها",
        album: "فقه العبادات",
        duration: "38:42",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/06/%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B5%D8%A7%D9%84%D8%AD_%D8%A2%D9%84_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_2021.jpg",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "1,876,543"
      },
      {
        id: 3,
        title: "آداب طالب العلم",
        album: "آداب وأخلاق",
        duration: "45:18",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/06/%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B5%D8%A7%D9%84%D8%AD_%D8%A2%D9%84_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_2021.jpg",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "1,654,321"
      },
      {
        id: 4,
        title: "الزكاة وأحكامها",
        album: "فقه العبادات",
        duration: "51:27",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/06/%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B5%D8%A7%D9%84%D8%AD_%D8%A2%D9%84_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_2021.jpg",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "1,432,156"
      },
      {
        id: 5,
        title: "بر الوالدين",
        album: "الآداب الإسلامية",
        duration: "36:54",
        image: "https://upload.wikimedia.org/wikipedia/commons/0/06/%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_%D8%B5%D8%A7%D9%84%D8%AD_%D8%A2%D9%84_%D8%A7%D9%84%D8%B4%D9%8A%D8%AE_2021.jpg",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "1,234,567"
      }
    ]
  end

  def mock_artist_albums
    [
      {
        id: 1,
        title: "دروس في العقيدة",
        year: "2023",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        lectures_count: 25
      },
      {
        id: 2,
        title: "فقه العبادات",
        year: "2022",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        lectures_count: 30
      },
      {
        id: 3,
        title: "الآداب الإسلامية",
        year: "2021",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        lectures_count: 20
      }
    ]
  end

  def mock_appears_on
    [
      {
        id: 1,
        title: "مجموعة العلماء الكبار",
        subtitle: "مختارات من محاضرات كبار العلماء",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        type: "مجموعة"
      },
      {
        id: 2,
        title: "المؤتمر العلمي السنوي",
        subtitle: "محاضرات من المؤتمر العلمي 2023",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        type: "مؤتمر"
      }
    ]
  end
end
