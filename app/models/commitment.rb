class Commitment < ActiveRecord::Base

  attr_localized :amount

  enum document: [:order_buy, :order_service, :order_expend]
  def self.document_str
  [
    'Orden de Compra',
    'Orden de Servicio',
    'Orden de Gasto'
  ]
  end
  
  belongs_to :lab

  validates :lab, presence: true
  validates :sae_code, presence: true
  validates :code, presence: true
  validates :code, numericality: { greater_than: 0 }, if: "!code.blank?"
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }, if: "!amount.blank?"
  validates :description, presence: true, length: {maximum: 512}
  validates :recipient, presence: true, length: {maximum: 512}
  validates :observations, length: {maximum: 1024}
  validates :date, presence: true
  validates_date :date, if: "!date.blank?"
end
