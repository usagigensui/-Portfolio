class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :profile_id, null: false
      t.string :title, null: false
      t.text :body
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.timestamps
    end
  end
end
