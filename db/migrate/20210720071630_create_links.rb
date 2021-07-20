class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.integer :profile_id, null: false
      t.text :url, null: false
      t.integer :category, null: false
      t.timestamps
    end
  end
end
