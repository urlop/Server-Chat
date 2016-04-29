json.array!(@contacts) do |contact|
  json.extract! contact, :id, :owner_id, :friend_id
  json.url contact_url(contact, format: :json)
end
