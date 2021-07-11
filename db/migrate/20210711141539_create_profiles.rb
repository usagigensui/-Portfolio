class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.string :code, null: false
      t.string :name, null: false
      t.text :introduction
      t.string :image_id
      t.timestamps
    end
  end
end
