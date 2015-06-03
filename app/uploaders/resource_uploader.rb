class ResourceUploader < CarrierWave::Uploader::Base
  include CarrierWave::MagicMimeTypes

  storage :grid_fs
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'uploads'

  process :set_content_type
end
