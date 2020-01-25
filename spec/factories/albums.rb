FactoryBot.define do
  factory :album do
    name { "MyString" }
    slug { "MyString" }
    visible { false }
    priority { 1 }
    uuid { "" }
    image { "MyString" }
    description { "MyString" }
    image_alt_text { "MyString" }
  end
end
