require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validating' do
    it 'fails when slug is blank' do
      category = build :category, slug: ''
      expect(category).not_to be_valid
    end

    it 'fails when slug is non-unique' do
      existing_category = create :category
      category = build :category, slug: existing_category.slug
      expect(category).not_to be_valid
    end

    it 'fails when name_ru is blank' do
      category = build :category, name_ru: ''
      expect(category).not_to be_valid
    end

    it 'fails when name_en is blank' do
      category = build :category, name_en: ''
      expect(category).not_to be_valid
    end

    it 'fails when name_es is blank' do
      category = build :category, name_es: ''
      expect(category).not_to be_valid
    end

    it 'fails when name_ru is not unique' do
      existing_category = create :category
      category = build :category, name_ru: existing_category.name_ru
      expect(category).not_to be_valid
    end

    it 'fails when name_en is not unique' do
      existing_category = create :category
      category = build :category, name_en: existing_category.name_en
      expect(category).not_to be_valid
    end

    it 'fails when name_es is not unique' do
      existing_category = create :category
      category = build :category, name_es: existing_category.name_es
      expect(category).not_to be_valid
    end

    it 'passes with valid attributes' do
      category = build :category
      expect(category).to be_valid
    end
  end

  describe '#name' do
    let(:category) { create :category }

    it 'returns name_ru for Russian locale' do
      expect(category.name :ru).to eq(category.name_ru)
    end

    it 'returns name_en for English locale' do
      expect(category.name :en).to eq(category.name_en)
    end

    it 'returns name_es for Spanish locale' do
      expect(category.name :es).to eq(category.name_es)
    end

    it 'returns slug for unknown locale' do
      expect(category.name :no).to eq(category.slug)
    end
  end

  describe '#description' do
    let(:category) { create :category_with_descriptions }

    it 'returns description_ru for Russian locale' do
      expect(category.description :ru).to eq(category.description_ru)
    end

    it 'returns description_en for English locale' do
      expect(category.description :en).to eq(category.description_en)
    end

    it 'returns description_es for Spanish locale' do
      expect(category.description :es).to eq(category.description_es)
    end

    it 'returns nil for unknown locale' do
      expect(category.description :no).to be_nil
    end
  end
end
