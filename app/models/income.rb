class Income < ActiveRecord::Base
  enum origin: [:ordinary, :extraordinary, :projects, :reformulation]
  belongs_to :lab

  validates :lab, :presence => true
  validates :amount, :presence => true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: {maximum: 512}
  validates :origin, presence: true
  validates :date, presence: true
  validates_datetime :date

  validates :organism, length: {maximum: 512}
  validates :financing, length: {maximum: 512} #!No se sabe si es obligatorio
  validates :document, length: {maximum: 512} #!No se sabe si es obligatorio

end
