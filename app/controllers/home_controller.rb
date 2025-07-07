# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    @recently_played = mock_recently_played
    @made_for_you = mock_made_for_you
    @popular_scholars = mock_popular_scholars
  end

  private

  def mock_recently_played
    [
      {
        id: 1,
        title: "المحاضرات المفضلة",
        subtitle: "749 محاضرة",
        image: "https://misc.scdn.co/liked-songs/liked-songs-640.png",
        type: "playlist"
      },
      {
        id: 2,
        title: "دروس العقيدة",
        subtitle: "الشيخ صالح الفوزان",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        type: "playlist"
      },
      {
        id: 3,
        title: "فقه العبادات",
        subtitle: "الشيخ محمد العثيمين",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        type: "playlist"
      },
      {
        id: 4,
        title: "رقائق القلوب",
        subtitle: "الشيخ ربيع المدخلي",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        type: "playlist"
      }
    ]
  end

  def mock_made_for_you
    [
      {
        id: 1,
        title: "اكتشف الأسبوعي",
        subtitle: "مجموعتك الأسبوعية من المحاضرات الجديدة",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228"
      },
      {
        id: 2,
        title: "الإصدارات الجديدة",
        subtitle: "محاضرات جديدة من العلماء الذين تتابعهم",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228"
      },
      {
        id: 3,
        title: "مزيج يومي 1",
        subtitle: "الشيخ الفوزان، الشيخ الألباني، الشيخ ابن باز والمزيد",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228"
      }
    ]
  end

  def mock_popular_scholars
    [
      {
        id: 1,
        name: "الشيخ صالح الفوزان",
        image: "https://i.scdn.co/image/ab6761610000e5eb214f3cf1cbe7139c1e26ffbb"
      },
      {
        id: 2,
        name: "الشيخ محمد الألباني",
        image: "https://i.scdn.co/image/ab6761610000e5eb214f3cf1cbe7139c1e26ffbb"
      },
      {
        id: 3,
        name: "الشيخ عبد العزيز ابن باز",
        image: "https://i.scdn.co/image/ab6761610000e5eb214f3cf1cbe7139c1e26ffbb"
      },
      {
        id: 4,
        name: "الشيخ عبيد الله الجابري",
        image: "https://i.scdn.co/image/ab6761610000e5eb214f3cf1cbe7139c1e26ffbb"
      },
      {
        id: 5,
        name: "الشيخ ربيع المدخلي",
        image: "https://i.scdn.co/image/ab6761610000e5eb214f3cf1cbe7139c1e26ffbb"
      },
      {
        id: 6,
        name: "الشيخ صالح آل الشيخ",
        image: "https://i.scdn.co/image/ab6761610000e5eb214f3cf1cbe7139c1e26ffbb"
      }
    ]
  end
end
