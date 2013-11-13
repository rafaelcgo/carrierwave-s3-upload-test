class CreatePhotoZips < ActiveRecord::Migration
  def change
    create_table :photo_zips do |t|
      t.string :file
      t.references :parent, polymorphic: true

      t.timestamps
    end

    add_index :photo_zips, [:parent_id, :parent_type]
  end
end
