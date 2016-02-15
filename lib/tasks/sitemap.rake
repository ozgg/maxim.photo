namespace :sitemap do
  include Rails.application.routes.url_helpers
  default_url_options[:host] = 'maxim.photo'
  default_url_options[:protocol] = 'http'

  desc 'Generate sitemap files'
  task generate: :environment do
    File.open "#{Rails.root}/public/sitemap.xml", 'w' do |file|
      file << '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
      file << "<url><loc>#{root_url}</loc></url>"
      file << "<url><loc>#{about_url}</loc></url>"

      Photo.all.each do |photo|
        location = portfolio_photo_url(theme: photo.theme.slug, album: photo.album.slug, id: photo.id)
        last_mod = photo.updated_at.strftime('%Y-%m-%dT%H:%M:%S%:z')
        file << "<url><loc>#{location}</loc><lastmod>#{last_mod}</lastmod></url>"
      end
      file << "</urlset>\n"
    end
  end
end
