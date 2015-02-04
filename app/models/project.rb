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
    'En espera de recursos',
    'En ejecución',
    'En reformulación',
    'Finalizado',
    'Anulado'
  ]
  end

  def incoming_date_required
      errors.add(:incoming_date, "no puede estar en blanco para cambiar el status")
  end

  def greater_zero?
  	  return other_amount > 0.00;
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
  validates_numericality_of :amount, :greater_than_or_equal_to => 0, if: "!amount.blank?"
  validates :equipments, presence: true
  validates_numericality_of :equipments, :greater_than_or_equal_to => 0, if: "!equipments.blank?"
  validates :services, presence: true
  validates_numericality_of :services, :greater_than_or_equal_to => 0, if: "!services.blank?"
  validates :infrastructure, presence: true
  validates_numericality_of :infrastructure, :greater_than_or_equal_to => 0, if: "!infrastructure.blank?"
  validates :hhrr, presence: true
  validates_numericality_of :hhrr, :greater_than_or_equal_to => 0, if: "!hhrr.blank?"
  validates :consumables, presence: true
  validates_numericality_of :consumables, :greater_than_or_equal_to => 0, if: "!consumables.blank?"
  validates :furniture, presence: true
  validates_numericality_of :furniture, :greater_than_or_equal_to => 0, if: "!furniture.blank?"
  validates :other_amount, presence: true
  validates_numericality_of :other_amount, :greater_than_or_equal_to => 0, if: "!other_amount.blank?"
  validates :other_desc, presence: true, if: "greater_zero?"

end
