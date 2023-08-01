FactoryBot.define do
  factory :story do
    date { "2023-08-01" }
    slug { "MyString" }
    name { "MyString" }
    description { "MyText" }
    image { "MyString" }
    image_alt_text { "MyString" }
  end
end
