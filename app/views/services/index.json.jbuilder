json.array!(@services) do |service|
  json.extract! service, :id, :nombre, :descripcion
  json.url service_url(service, format: :json)
end
