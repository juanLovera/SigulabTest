class Act < ActiveRecord::Base
	validates_presence_of :numRegistro
	validates_presence_of :proveedor
	validates_presence_of :bienServicio
	validates_presence_of :tesis
	validates_presence_of :responsable
	validates_presence_of :justificacion
	validates_presence_of :providencia

   belongs_to :user
   belongs_to :specification
end
