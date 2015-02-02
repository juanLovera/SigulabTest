class Project < ActiveRecord::Base

  enum admin: [:marquez, :villa]
  def self.admin_str
  [
    'Magaly Márquez',
    'Thailyn Villa'
  ]
  end

  enum status: [:pending, :executing, :reformulating, :finished, :annulled]
  def self.status_str
  [
    'Por aprobar',
    'En ejecución',
    'En reformulación',
    'Finalizado',
    'Anulado'
  ]
  end

  validates :project_number, presence: true
  validates :project_number, numericality: { greater_than: 0 }, if: "!project_number.blank?"
  validates :contract, presence: true
  validates :contract, numericality: { greater_than: 0 }, if: "!contract.blank?"
  validates :title, presence: true
  validates :responsible, presence: true
  validates :admin, presence: true
  validates :sae_code, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }, if: "!amount.blank?"
  validates :equipments, presence: true
  validates :equipments, numericality: { greater_than_or_equal_to: 0 }, if: "!equipments.blank?"
  validates :services, presence: true
  validates :services, numericality: { greater_than_or_equal_to: 0 }, if: "!services.blank?"
  validates :infrastructure, presence: true
  validates :infrastructure, numericality: { greater_than_or_equal_to: 0 }, if: "!infrastructure.blank?"
  validates :hhrr, presence: true
  validates :hhrr, numericality: { greater_than_or_equal_to: 0 }, if: "!hhrr.blank?"
  validates :consumables, presence: true
  validates :consumables, numericality: { greater_than_or_equal_to: 0 }, if: "!consumables.blank?"
  validates :incoming_date, presence: true  
  validates_date :incoming_date, if: "!incoming_date.blank?"
  validates :status, presence: true

end
