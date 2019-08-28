json.data @collection do |entity|
  json.id entity.id
  json.type entity.class.table_name
  json.attributes do
    json.call(entity, :image_alt_text)
  end
  json.meta do
    json.image_url entity.image.medium_url
    json.featured entity.featured?
    json.featured_url admin_featured_photo_path(id: entity.id)
  end
end
json.partial! 'shared/pagination', locals: { collection: @collection }
