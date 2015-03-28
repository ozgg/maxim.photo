FactoryGirl.define do
  factory :album do
    sequence(:slug) { |n| "album-#{n}" }
    sequence(:name_ru) { |n| "Альбом #{n}" }
    sequence(:name_en) { |n| "Album #{n}" }
    sequence(:name_es) { |n| "Álbum #{n}" }

    factory :hidden_album do
      hidden true
    end

    factory :album_with_descriptions do
      description_ru 'Описание'
      description_en 'Description'
      description_es 'Descriptión'
    end
  end
end
