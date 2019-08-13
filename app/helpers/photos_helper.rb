# frozen_string_literal: true

# Helper methods for handling photos component
module PhotosHelper
  # @param [Album] entity
  # @param [String] text
  # @param [Hash] options
  def admin_album_link(entity, text = entity.name, options = {})
    link_to(text, admin_album_path(id: entity.id), options)
  end

  # @param [Photo] entity
  # @param [String] text
  # @param [Hash] options
  def admin_photo_link(entity, text = entity.title!, options = {})
    link_to(text, admin_photo_path(id: entity.id), options)
  end

  # @param [PhotoTag] entity
  # @param [String] text
  # @param [Hash] options
  def admin_photo_tag_link(entity, text = entity.name, options = {})
    link_to(text, admin_photo_tag_path(id: entity.id), options)
  end
end
