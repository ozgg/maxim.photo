require 'rails_helper'

RSpec.describe Album, type: :model, wip: true do
  context 'validating' do
    it 'passes with valid attributes'
    it 'fails without slug'
    it 'fails without Russian name'
    it 'fails without English name'
    it 'fails without Spanish name'
    it 'fails with non-unique slug'
    it 'fails with non-unique Russian name'
    it 'fails with non-unique English name'
    it 'fails with non-unique Spanish name'
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
