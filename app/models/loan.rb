class Loan < ActiveRecord::Base
	validates_presence_of :ubicacion
	validates_presence_of :condiciones
	validates_presence_of :fechaEntrega
	validates_presence_of :fechaTope
	has_many :table_items_solicitud

	validate :fechas

	def fechas
	    if fechaEntrega > fechaTope
	      errors.add(:fechaEntrega, "no puede ser posterior a la fecha de petición")
	    end
	end

end
