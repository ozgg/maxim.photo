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
end
