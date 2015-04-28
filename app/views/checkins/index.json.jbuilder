json.array!(@checkins) do |checkin|
  json.extract! checkin, :id, :codigo_evento, :nombre, :puesto, :correo, :nombre_evento
  json.url checkin_url(checkin, format: :json)
end
