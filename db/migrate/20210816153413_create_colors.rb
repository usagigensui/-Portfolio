class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.integer :profile_id, null: false
      t.integer :text, default: 0
      t.integer :background, default: 0
      t.integer :accent, default: 0
      t.timestamps
    end
  end
end
