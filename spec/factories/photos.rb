FactoryBot.define do
  factory :photo do
    album { nil }
    uuid { "" }
    priority { 1 }
    image { "MyString" }
    image_alt_text { "MyString" }
    title { "MyString" }
    description { "MyText" }
  end
end
