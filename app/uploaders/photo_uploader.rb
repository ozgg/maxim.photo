# frozen_string_literal: true

# Image uploader for photos component
class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    id = model&.id.to_i
    slug = "#{id / 1000}/#{id}"

    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{slug}"
  end

  def default_url(*)
    ActionController::Base.helpers.asset_path('biovision/base/placeholders/3x2.svg')
  end

  version :hd do
    resize_to_fit(1280, 720)
  end

  version :large, from_version: :hd do
    resize_to_fit(960, 540)
  end

  version :medium, from_version: :large do
    resize_to_fit(640, 360)
  end

  version :small, from_version: :medium do
    resize_to_fit(320, 180)
  end

  version :preview, from_version: :small do
    resize_to_fit(160, 160)
  end

  def extension_whitelist
    %w[jpg jpeg]
  end

  # Text for image alt attribute
  #
  # @param [String] default
  # @return [String]
  def alt_text(default = '')
    method_name = "#{mounted_as}_alt_text".to_sym
    if model.respond_to?(method_name)
      model.send(method_name)
    else
      default
    end
  end

  def raster?
    true
  end

  def preview_url
    preview.url
  end

  def small_url
    small.url
  end

  def medium_url
    medium.url
  end

  def large_url
    large.url
  end

  def hd_url
    hd.url
  end
end
