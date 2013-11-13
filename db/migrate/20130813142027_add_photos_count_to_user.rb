class AddPhotosCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :photos_count, :integer, default: 0

    User.reset_column_information
    User.find(:all).each do |u|
      User.update_counters u.id, photos_count: u.photos.length
    end
  end
end
