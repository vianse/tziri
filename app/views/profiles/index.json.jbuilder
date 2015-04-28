json.array!(@profiles) do |profile|
  json.extract! profile, :id, :nombre, :puesto, :movil, :user_id
  json.url profile_url(profile, format: :json)
end
