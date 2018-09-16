class PhotoImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg)
  end

  version :big do
    resize_to_fit(1280, 1280)
  end

  version :medium, from_version: :big do
    resize_to_fit(640, 640)
  end

  version :small, from_version: :medium do
    resize_to_fit(320, 320)
  end

  version :preview_2x, from_version: :small do
    resize_to_fit(160, 160)
  end

  version :preview, from_version: :preview_2x do
    resize_to_fit(80, 80)
  end
end