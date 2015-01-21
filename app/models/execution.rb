#!/bin/env ruby
# encoding: utf-8

class Execution < ActiveRecord::Base
  enum document: [:reception_report, :according_service]
  def self.document_str
  [
    "Informe de Recepción",
    "Conformidad de Servicio"
  ]
  end

  belongs_to :commitment
  
  validates :commitment, presence: true
  validates :code, presence: true
  validates :code, numericality: { greater_than: 0 }, if: "!code.blank?"
  validates :check_amount, presence: true
  validates :check_amount, numericality: { greater_than: 0 }, if: "!check_amount.blank?"
  validates :check_number, presence: true
  validates :check_number, numericality: { greater_than: 0 }, length: { is: 8 }, if: "!check_number.blank?"
  validates :check_elaboration_date, presence: true
  validates :check_sign_date, presence: true, if: "!check_delivery_date.blank?"
  validates_date :check_elaboration_date, if: "!check_elaboration_date.blank?"
  validates_date :check_sign_date, if: "!check_sign_date.blank?"
  validates_date :check_delivery_date, if: "!check_delivery_date.blank?"

  validate :elaboration_sign, if: "!check_sign_date.blank?"
  validate :sign_delivery, if: "!check_delivery_date.blank?"
 
  def elaboration_sign
    if check_elaboration_date > check_sign_date
      errors.add(:check_elaboration_date, "no puede ser posterior a la fecha de firma")
    end
  end 

  def sign_delivery
    if check_sign_date > check_delivery_date
      errors.add(:check_sign_date, "no puede ser posterior a la fecha de entrega")
    end
  end 

  def annul
    check_annulled = true
  end
	  
end
