class AddOriginalFilenameToPhoto < ActiveRecord::Migration
  def up
    add_column :photos, :original_filename, :string
    Photo.reset_column_information
    Photo.all.each {|p| p.original_filename = File.basename(p.photo.path); p.save}
  end
  def down
    remove_column :photos, :original_filename
  end
end
