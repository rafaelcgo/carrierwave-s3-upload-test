class AddPermalinkToEvent < ActiveRecord::Migration
  def change
    add_column :events, :permalink, :string
    Event.reset_column_information

    Event.all.each do |e|
      e.permalink = SecureRandom.urlsafe_base64(8) while Event.find_by(permalink: e.permalink)
      e.save
    end

  end

  def down
    remove_column :events, :permalink
  end
end
