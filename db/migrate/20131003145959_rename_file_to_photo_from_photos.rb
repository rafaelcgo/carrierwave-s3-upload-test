class RenameFileToPhotoFromPhotos < ActiveRecord::Migration
  def up
    rename_column :photos, :file, :photo
  end
  def down
    rename_column :photos, :photo, :file
  end
end
