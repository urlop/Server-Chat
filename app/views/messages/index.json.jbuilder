json.array!(@messages) do |message|
  json.extract! message, :id, :sender_id, :receiver_user_id, :receiver_room_id, :content
  json.url message_url(message, format: :json)
end
