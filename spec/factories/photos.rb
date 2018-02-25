FactoryBot.define do
  factory :photo do
    album nil
    priority 1
    visible false
    highlight false
    caption "MyString"
    slug "MyString"
    image "MyString"
    image_alt_text "MyString"
    description "MyText"
    meta_title "MyString"
    meta_keywords "MyString"
    meta_description "MyString"
  end
end
