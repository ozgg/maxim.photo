# frozen_string_literal: true

namespace :instagram do
  desc "Refresh image list for instagram feed"
  task refresh: :environment do
    doc = Nokogiri::HTML(OpenURI.open_uri('https://www.instagram.com/maximkm/'))
    script = doc.css('script[contains("edge_owner_to_timeline_media")]').inner_text
    json = JSON.parse(script.gsub(/\A[^{]+/, '').gsub(/;$/, ''))
    edges = json.dig('entry_data', 'ProfilePage', 0, 'graphql', 'user', 'edge_owner_to_timeline_media', 'edges')
    edges.reverse.each do |edge|
      slug = edge.dig('node', 'id')

      next if InstagramImage.where(slug: slug).exists?

      attributes = {
        slug: slug,
        code: edge.dig('node', 'shortcode')
      }

      edge.dig('node', 'thumbnail_resources').each do |thumbnail|
        if thumbnail['config_width'].to_i == 320
          attributes[:thumbnail_url] = thumbnail['src']
          break
        end
      end

      InstagramImage.create(attributes)
    end
  end
end
