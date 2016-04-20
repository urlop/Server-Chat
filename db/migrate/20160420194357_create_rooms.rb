class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :socket_id
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
