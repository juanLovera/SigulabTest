json.array!(@loans) do |loan|
  json.extract! loan, :id, :fechaEntrega, :ubicacion, :fechaTope, :condiciones, :medida
  json.url loan_url(loan, format: :json)
end
