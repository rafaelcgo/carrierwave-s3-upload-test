class AddPhotosCountToEvent < ActiveRecord::Migration
  def change
    add_column :events, :photos_count, :integer, default: 0

    Event.reset_column_information
    Event.find(:all).each do |e|
      Event.update_counters e.id, photos_count: e.photos.length
    end
  end
end
