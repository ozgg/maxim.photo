FactoryBot.define do
  factory :album do
    name { "MyString" }
    slug { "MyString" }
    visible { false }
    photos_count { 1 }
    image { "MyString" }
    description { "MyString" }
    image_alt_text { "MyString" }
  end
end
