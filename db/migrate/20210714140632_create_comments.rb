class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :profile_id, null: false
      t.string :title
      t.text :text, null: false
      t.timestamps
    end
  end
end
