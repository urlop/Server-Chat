json.array!(@rooms) do |room|
  json.extract! room, :id, :name, :socket_id, :owner_id
  json.url room_url(room, format: :json)
end
