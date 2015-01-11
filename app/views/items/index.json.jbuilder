json.array!(@items) do |item|
  json.extract! item, :id, :nombre, :descripcion, :dimensiones, :cantidad, :unidad
  json.url item_url(item, format: :json)
end
