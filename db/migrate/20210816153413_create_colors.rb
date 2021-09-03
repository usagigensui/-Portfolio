class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.string :profile_id, null: false
      t.string :text, default: "#495057"
      t.string :background, default: "#ffffff"
      t.string :accent, default: "#a9a9a9"
      t.timestamps
    end
  end
end
