# encoding: utf-8
class Item < ActiveRecord::Base
  
  TipoItem = ['Equipos y mobiliarios', 'Instrumentos de medición', 'Herramientas', 
              'Sustancias químicas', 'Consumibles y materiales']

  validates_presence_of :nombre, :message => "del Item no puede estar en blanco"
  validates_presence_of :descripcion, :message =>"del Item no puede estar en blanco"
  validates_numericality_of :cantidad, :greater_than => 0, :message => "debe ser mayor que 0"
  validates_presence_of :cantidad, :message => "del Item no puede estar en blanco"
  validates :dimesiones, presence: false
  validates_presence_of :tipo, :message => "del Item no puede estar en blanco" 
  validates_presence_of :unidad, :message => "del Item no puede estar en blanco" 
  validates :numeroBien, presence: false

  belongs_to :user

end
