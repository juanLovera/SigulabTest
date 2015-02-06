# encoding: utf-8
class Item < ActiveRecord::Base
  
  TipoItem = ['Equipos y mobiliarios', 'Instrumentos de medición', 'Herramientas', 
              'Sustancias químicas', 'Consumibles y materiales']
            
  UnidadMedida = ['cms', 'mts', 'in']

  validates_presence_of :tipo, :message => "del Item no puede estar en blanco" 
  validates_presence_of :nombre, :message => "del Item no puede estar en blanco"
  validates_numericality_of :cantidad, :greater_than => 0, :message => "debe ser un número mayor que 0"
  validates_presence_of :cantidad, :message => "del Item no puede estar en blanco"
  validates :dimensiones_largo, presence: false
  validates_numericality_of :dimensiones_largo, :greater_than_or_equal_to => 0, :message => "debe ser un número mayor que 0"
  validates :dimensiones_alto, presence: false
  validates_numericality_of :dimensiones_alto, :greater_than_or_equal_to => 0, :message => "debe ser un número mayor que 0"
  validates :dimensiones_ancho, presence: false
  validates_numericality_of :dimensiones_ancho, :greater_than_or_equal_to => 0, :message => "debe ser un número mayor que 0"
  validates :descripcion, presence: false
  
  belongs_to :user

end
