class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :file
      t.references :parent, polymorphic: true
      t.references :user, index: true

      t.timestamps
    end

    add_index :photos, [:parent_id, :parent_type]
  end
end
