class CreateFunctionSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :function_settings do |t|
      t.integer :profile_id, null: false
      t.boolean :timeline, default: false
      t.boolean :schedule, default: false
      t.boolean :gallery, default: false
      t.boolean :mail, default: false
      t.timestamps
    end
  end
end
