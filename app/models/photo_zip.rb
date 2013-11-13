class PhotoZip < ActiveRecord::Base
	belongs_to :parent, polymorphic: true

	validates_presence_of :file

  mount_uploader :file, PhotoZipUploader
end
