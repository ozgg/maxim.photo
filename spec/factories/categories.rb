FactoryGirl.define do
  factory :category do
    visibility 2
    sequence(:slug) { |n| "category-#{n}" }
    sequence(:name_ru) { |n| "Категория #{n}" }
    sequence(:name_en) { |n| "Category #{n}" }
    sequence(:name_es) { |n| "Categoría #{n}" }

    factory :visible_category do
      visibility 1
    end

    factory :hidden_category do
      visibility 0
    end
  end
end
