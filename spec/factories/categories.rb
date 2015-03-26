FactoryGirl.define do
  factory :category do
    visibility 1
    sequence(:slug) { |n| "category-#{n}" }
    sequence(:name_ru) { |n| "Категория #{n}" }
    sequence(:name_en) { |n| "Category #{n}" }
    sequence(:name_es) { |n| "Categoría #{n}" }
  end
end
