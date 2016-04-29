class Room < ActiveRecord::Base
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_one :user, foreign_key: :owner_id
  has_many :messages, foreign_key: :receiver_room_id

  validates_associated :user 
end
