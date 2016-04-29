class Contact < ActiveRecord::Base
  belongs_to :owner, :class_name=>'User', foreign_key: :owner_id
  belongs_to :friend, :class_name=>'User', foreign_key: :friend_id

  validates_associated :owner
  validates_associated :friend
end
