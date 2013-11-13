class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.references :place, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
