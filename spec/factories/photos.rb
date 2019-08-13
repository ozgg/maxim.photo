FactoryBot.define do
  factory :photo do
    album { nil }
    visible { false }
    priority { 1 }
    title { "MyString" }
    image { "MyString" }
    image_alt_text { "MyString" }
    meta_title { "MyString" }
    meta_description { "MyString" }
    meta_keywords { "MyString" }
  end
end
