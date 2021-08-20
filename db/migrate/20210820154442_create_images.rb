class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.integer :profile_id, null: false
      t.string :title
      t.string :body_id, null: false
      t.text :information
      t.timestamps
    end
  end
end
