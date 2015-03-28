require 'rails_helper'

RSpec.describe CategoriesHelper, type: :helper do
  describe '#category_by_slug' do
    let(:category) { create :category }

    it 'returns link with category slug as id' do
      expected_link = link_to category.name(I18n.locale), category_path(id: category.slug)
      expect(helper.category_by_slug(category)).to eq(expected_link)
    end
  end
end
