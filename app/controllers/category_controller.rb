# app/controllers/category_controller.rb
class CategoryController < ApplicationController
  def index
    @categories = mock_categories
  end

  def show
    @category = mock_category
    @playlists = mock_category_playlists
  end

  private

  def mock_categories
    [
      {
        id: 1,
        name: "العقيدة",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        color: "bg-gradient-to-br from-blue-600 to-blue-800"
      },
      {
        id: 2,
        name: "الفقه",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        color: "bg-gradient-to-br from-green-600 to-green-800"
      },
      {
        id: 3,
        name: "التفسير",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        color: "bg-gradient-to-br from-purple-600 to-purple-800"
      },
      {
        id: 4,
        name: "الحديث",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        color: "bg-gradient-to-br from-red-600 to-red-800"
      },
      {
        id: 5,
        name: "السيرة النبوية",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        color: "bg-gradient-to-br from-yellow-600 to-yellow-800"
      },
      {
        id: 6,
        name: "الرقائق",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        color: "bg-gradient-to-br from-indigo-600 to-indigo-800"
      }
    ]
  end

  def mock_category
    {
      id: params[:id],
      name: "العقيدة",
      description: "محاضرات وشروحات في العقيدة الإسلامية الصحيحة",
      image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
      color: "bg-gradient-to-br from-blue-600 to-blue-800"
    }
  end

  def mock_category_playlists
    [
      {
        id: 1,
        title: "دروس العقيدة السلفية",
        subtitle: "أهم دروس العقيدة الإسلامية الصحيحة",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        lectures_count: 50
      },
      {
        id: 2,
        title: "شرح العقيدة الواسطية",
        subtitle: "شرح مفصل للعقيدة الواسطية لابن تيمية",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        lectures_count: 25
      },
      {
        id: 3,
        title: "كتاب التوحيد",
        subtitle: "شرح كتاب التوحيد للشيخ محمد بن عبد الوهاب",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        lectures_count: 40
      },
      {
        id: 4,
        title: "أصول الإيمان",
        subtitle: "محاضرات في أصول الإيمان الستة",
        image: "https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228",
        lectures_count: 30
      }
    ]
  end
end
