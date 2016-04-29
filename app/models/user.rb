class User < ActiveRecord::Base
  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  has_many :sent_messages, :class_name=>'Message', foreign_key: :sender_id
  has_many :recieved_messages, :class_name=>'Message', foreign_key: :receiver_user_id

  validates_uniqueness_of :name

  scope :friends, -> (id) { where.not(id: id) }
  scope :friends_by_name, -> (name) { where.not(name: name) }
end
