require 'zip/zip'
require 'zip/zipfilesystem'

class PhotoZipper
	extend RetriedJob
  @queue = :photozip_queue

  def self.perform(object_id, object_type, user_id)
  	object = object_type.classify.constantize.find(object_id)
    zip = PhotoZipper.generate_zip(object)

    NotificationsMailer.zip_ready(zip.file.file.url, user_id).deliver
  rescue Resque::TermException
    logger.info "[TermException] ([#{object_id}, #{object_type}, #{user_id}]). Requeuing..."
    Resque.enqueue(self, key)
  end

	# Zipfile generator
  def self.generate_zip(object)
    photos = object.photos
    # base temp dir
    temp_dir = Dir.mktmpdir
    # path for zip we are about to create, I find that ruby zip needs to write to a real file
    zip_path = File.join(temp_dir, "#{object.name}_#{Date.today.to_s}.zip")

    # folder inside the zipfile
    folder = 'Test/fotos/'

    # create the zip file
    Zip::ZipOutputStream.open(zip_path) do |zos|
      photos.each do |photo|
        path = folder + photo.photo.path.split('/').last
        zos.put_next_entry(path)
        zos.write photo.photo.file.read
      end
    end

    # upload the zip file
    zip = PhotoZip.find_or_initialize_by(parent: object)
    zip.file = File.open(zip_path)
    zip.save!

    # return the zip object
    return zip
  ensure
    # clean up the tempdir now!
    FileUtils.rm_rf temp_dir if temp_dir
  end
end