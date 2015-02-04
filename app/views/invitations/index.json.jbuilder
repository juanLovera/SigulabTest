json.array!(@invitations) do |invitation|
  json.extract! invitation, :id, :nombreEmpresa, :direccion, :telefono, :string, :correo, :numeroAdicional, :string, :responsable
  json.url invitation_url(invitation, format: :json)
end
