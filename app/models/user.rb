class User < ActiveRecord::Base
  has_many :user_rooms
  has_many :rooms, through: :user_rooms
end
