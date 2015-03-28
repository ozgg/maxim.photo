FactoryGirl.define do
  factory :photo do
    image "image.jpg"

    factory :photo_with_names do
      name_ru "Картинка"
      name_en "Image"
      name_es "Imagen"
    end
  end
end
