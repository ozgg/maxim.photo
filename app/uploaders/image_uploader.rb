class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :big do
    process resize_to_fit: [1280, 720]
  end

  version :medium, from_version: :big do
    process resize_to_fit: [640, 360]
  end

  version :big_square, from_version: :big do
    process resize_to_fill: [720, 720]
  end

  version :medium_square, from_version: :big_square do
    process resize_to_fit: [360, 360]
  end

  version :small_square, from_version: :medium_square do
    process resize_to_fit: [180, 180]
  end

  def extension_white_list
    %w(jpg jpeg)
  end
end
