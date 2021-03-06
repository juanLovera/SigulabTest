#!/bin/env ruby
# encoding: utf-8

class Income < ActiveRecord::Base

  attr_localized :amount

  enum origin: [:ordinary, :extraordinary, :reformulation]
  def self.origin_str
  [
    'Presupuesto Ordinario',
    'Presupuesto Extraordinario',
    'Reformulación'
  ]
  end
  
  enum financing: [:transfer_public, :transfer_private, :donation_public, :donation_private, :locti]
  def self.financing_str
  [
    'Transferencias Recibidas del Sector Publico',
    'Transferencias Recibidas del Sector Privado',
    'Donaciones Recibidas del Sector Público',
    'Donaciones Recibidas del Sector Privado',
    'LOCTI'
  ]
  end

  enum resource: [:project, :goal, :expenses, :incomes]
  def self.resource_str
  [
    'Proyecto',
    'Meta',
    'Gasto',
    'Inversiones'
  ]
  end

  mount_uploader :document, AttachmentUploader # Tells rails to use this uploader for this model.
  
  belongs_to :lab
  
  validates :lab, presence: true
  validates :sae_code, presence: true
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }, if: "!amount.blank?"
  validates :description, presence: true, length: {maximum: 512}
  validates :origin, presence: true
  validates :date, presence: true  
  validates_date :date, if: "!date.blank?"
  validates :doc_date, presence: true  
  validates_date :doc_date, if: "!doc_date.blank?"
  validates :doc_code, presence: true
  validates :doc_code, numericality: { greater_than: 0 }, if: "!doc_code.blank?"

  validates :organism, length: {maximum: 512}
  validates :document, presence: true

  validates :unit, length: {maximum: 512}
  validates :variation, length: {maximum: 512}
  validates :resource_description, length: {maximum: 1024}

  validates :financing, presence: true
  validates :organism, presence: true
  
end
