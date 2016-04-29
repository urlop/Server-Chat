class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_user_id
      t.integer :receiver_room_id
      t.string :content

      t.timestamps null: false
    end
  end
end
