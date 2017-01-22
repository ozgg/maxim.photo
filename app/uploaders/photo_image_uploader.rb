class PhotoImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg)
  end

  resize_to_fit(1920, 1080)

  version :big do
    resize_to_fit(1280, 720)
  end

  version :medium, from_version: :big do
    resize_to_fit(640, 360)
  end

  version :small, from_version: :medium do
    resize_to_fit(320, 180)
  end

  version :thumbnail_2x, from_version: :small do
    resize_to_fit(160, 160)
  end

  version :thumbnail, from_version: :thumbnail_2x do
    resize_to_fit(80, 80)
  end
end
