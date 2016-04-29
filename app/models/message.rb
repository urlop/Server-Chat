class Message < ActiveRecord::Base
  belongs_to :sender, :class_name=>'User', foreign_key: :sender_id
  belongs_to :reciever_user, :class_name=>'User', foreign_key: :receiver_user_id
  belongs_to :reciever_room, :class_name=>'Room', foreign_key: :receiver_room_id

  validates_associated :sender
end
