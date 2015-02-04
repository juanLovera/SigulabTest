class Commitment < ActiveRecord::Base
  #Required on integration #!
  #belongs_to :commitable, polymorphic: true
  enum origin: [:ordinary, :extraordinary, :projects, :reformulation]
  belongs_to :lab

  validates :lab, presence: true
  validates :code, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true, length: {maximum: 512}
  validates :recipient, presence: true, length: {maximum: 512}
  validates :date, presence: true
  validates_datetime :date
end
