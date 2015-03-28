require 'rails_helper'

RSpec.describe AlbumsHelper, type: :helper do
  describe '#album_by_slug' do
    let(:album) { create :album }

    it 'returns link with album slug as id' do
      expected_link = link_to album.name(I18n.locale), album_path(id: album.slug)
      expect(helper.album_by_slug(album)).to eq(expected_link)
    end
  end
end
