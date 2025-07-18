# app/controllers/album_controller.rb
class AlbumController < ApplicationController
  def show
    @album = mock_album
    @lectures = mock_album_lectures
  end

  private

  def mock_album
    {
      id: params[:id],
      title: "دروس في العقيدة",
      artist: "الشيخ صالح الفوزان",
      year: "2023",
      image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
      total_lectures: 25,
      total_duration: "18 ساعة 45 دقيقة",
      description: "مجموعة شاملة من المحاضرات في العقيدة الإسلامية الصحيحة"
    }
  end

  def mock_album_lectures
    [
      {
        id: 1,
        title: "مقدمة في العقيدة الإسلامية",
        duration: "45:20",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "1,234,567"
      },
      {
        id: 2,
        title: "أركان الإيمان الستة",
        duration: "52:15",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "987,654"
      },
      {
        id: 3,
        title: "التوحيد وأقسامه",
        duration: "48:30",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "876,543"
      },
      {
        id: 4,
        title: "الشرك وأنواعه",
        duration: "41:25",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "765,432"
      },
      {
        id: 5,
        title: "الإيمان بالله تعالى",
        duration: "39:18",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "654,321"
      },
      {
        id: 6,
        title: "الإيمان بالملائكة",
        duration: "42:42",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "543,210"
      },
      {
        id: 7,
        title: "الإيمان بالكتب",
        duration: "38:55",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "432,109"
      },
      {
        id: 8,
        title: "الإيمان بالرسل",
        duration: "46:33",
        audio_url: "https://saleh.af.org.sa/sites/default/files/2018-01/%D8%B3%D8%A7%D8%A6%D9%84%20%D9%8A%D9%82%D9%88%D9%84%20%20%D9%85%D8%A7%20%D9%87%D9%8A%20%D8%A7%D9%84%D9%88%D8%B3%D8%A7%D8%A6%D9%84%20%D8%A7%D9%84%D9%85%D8%B9%D9%8A%D9%86%D8%A9%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%84%D8%AA%D9%81%D9%82%D9%87%20%D9%81%D9%8A%20%D8%AF%D9%8A%D9%86%20%D8%A7%D9%84%D9%84%D9%87%20%D8%9F.mp3",
        plays: "321,098"
      }
    ]
  end
end
