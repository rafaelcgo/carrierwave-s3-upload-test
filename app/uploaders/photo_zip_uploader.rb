class PhotoZipUploader < CarrierWave::Uploader::Base
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  storage :fog

  def store_dir
    "uploads/#{model.parent.class.to_s.underscore}/#{model.class.to_s.underscore}/#{model.parent.id}"
  end

  def extension_white_list
    %w(zip)
  end

  def fog_public
    true
  end
end
