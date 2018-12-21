class CreateGroupEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :group_events do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.date :starts
      t.date :ends
      t.text :name, index: true
      t.text :description
      t.text :location
      t.boolean :published, default: false, null: false
      t.boolean :soft_deleted, default: false, null: false

      t.timestamps
    end
  end
end
