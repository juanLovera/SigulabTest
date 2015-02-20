class Projcommitment < ActiveRecord::Base

	  belongs_to :project

   enum document: [:order_buy, :order_service, :order_expend]
  def self.document_str
  [
    'Orden de Compra',
    'Orden de Servicio',
    'Orden de Gasto'
  ]
  end
end
