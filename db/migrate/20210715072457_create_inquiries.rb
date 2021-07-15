class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.integer :profile_id, null: false
      t.string :sender, null: false
      t.string :email, null: false
      t.string :title
      t.text :message, null: false
      t.timestamps
    end
  end
end
