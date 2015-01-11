# encoding: utf-8
class Service < ActiveRecord::Base
  TipoServicio = ['Reparación', 'Alquiler', 'Mantenimiento', 'Instalación', 'Calibración']
  validates_presence_of :nombre, :message => "del servicio no puede estar en blanco"
  validates_presence_of :tipo
  validates_presence_of :numeroBien
  validates_presence_of :descripcion
  validates_presence_of :ubicacion
  belongs_to :user

end
