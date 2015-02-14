class Request < ActiveRecord::Base
  Fondos = ['El FONACIT', 'El Decanato de Investicacion y Desarrollo', 'FUNINDES', 'El Presupuesto Ordinario, ULab', 'El Presupuesto Ordinario D.S.T.', 'Otro', 'Accesorio', 'Otro']
  Cuenta = ['Ahorro', 'Corriente']
  mount_uploader :proforma, AttachmentUploader
  mount_uploader :fonacit, AttachmentUploader
  mount_uploader :folleto, AttachmentUploader
  mount_uploader :acta_consejo_directo, AttachmentUploader
  belongs_to :user
end
