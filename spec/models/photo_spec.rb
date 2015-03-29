require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe '#name' do

    context 'when name is set for locale' do
      let(:photo) { create :photo_with_names }

      it 'returns Russian name for Russian locale' do
        pending
        expect(photo.name(:ru)).to eq(photo.name_ru)
      end

      it 'returns English name for English locale' do
        pending
        expect(photo.name(:en)).to eq(photo.name_en)
      end

      it 'returns Spanish name for Spanish locale' do
        pending
        expect(photo.name(:es)).to eq(photo.name_es)
      end
    end

    context 'when name is not set for locale' do
      let(:photo) { create :photo }

      it 'returns "untitled" in current locale' do
        pending
        expect(photo.name(I18n.locale)).to eq(I18n.t(:untitled))
      end
    end
  end
end
