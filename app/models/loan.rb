class Loan < ActiveRecord::Base
	validates_presence_of :ubicacion
	validates_presence_of :condiciones
	validates_presence_of :fechaEntrega
	validates_presence_of :fechaTope
end
