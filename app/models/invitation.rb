class Invitation < ActiveRecord::Base
	validates_presence_of :nombreEmpresa
	validates_presence_of :direccion
	validates_presence_of :correo
	validates_presence_of :telefono
	validates :telefonoAdicional, presence: false
	validates_presence_of :responsable
   belongs_to :user
end
