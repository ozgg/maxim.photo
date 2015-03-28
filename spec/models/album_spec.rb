require 'rails_helper'

RSpec.describe Album, type: :model do
  context 'validating' do
    it 'passes with valid attributes' do
      album = build :album
      expect(album).to be_valid
    end

    it 'fails without slug' do
      album = build :album, slug: ''
      expect(album).not_to be_valid
    end

    it 'fails without Russian name' do
      album = build :album, name_ru: ''
      expect(album).not_to be_valid
    end

    it 'fails without English name' do
      album = build :album, name_en: ''
      expect(album).not_to be_valid
    end

    it 'fails without Spanish name' do
      album = build :album, name_es: ''
      expect(album).not_to be_valid
    end

    it 'fails with non-unique slug' do
      existing_album = create :album
      album = build :album, slug: existing_album.slug
      expect(album).not_to be_valid
    end

    it 'fails with non-unique Russian name' do
      existing_album = create :album
      album = build :album, name_ru: existing_album.name_ru
      expect(album).not_to be_valid
    end

    it 'fails with non-unique English name' do
      existing_album = create :album
      album = build :album, name_en: existing_album.name_en
      expect(album).not_to be_valid
    end

    it 'fails with non-unique Spanish name' do
      existing_album = create :album
      album = build :album, name_es: existing_album.name_es
      expect(album).not_to be_valid
    end
  end
  
  describe '#name' do
    let(:album) { create :album }

    it 'returns name_ru for Russian locale' do
      expect(album.name :ru).to eq(album.name_ru)
    end

    it 'returns name_en for English locale' do
      expect(album.name :en).to eq(album.name_en)
    end

    it 'returns name_es for Spanish locale' do
      expect(album.name :es).to eq(album.name_es)
    end

    it 'returns slug for unknown locale' do
      expect(album.name :no).to eq(album.slug)
    end
  end

  describe '#description' do
    let(:album) { create :album_with_descriptions }

    it 'returns description_ru for Russian locale' do
      expect(album.description :ru).to eq(album.description_ru)
    end

    it 'returns description_en for English locale' do
      expect(album.description :en).to eq(album.description_en)
    end

    it 'returns description_es for Spanish locale' do
      expect(album.description :es).to eq(album.description_es)
    end

    it 'returns nil for unknown locale' do
      expect(album.description :no).to be_nil
    end
  end
end
