class Loan < ActiveRecord::Base
	validates_presence_of :ubicacion, :presence => {:message => "no puede ser blanco"}
	validates_presence_of :condiciones, :presence => {:message => "no puede ser blanco"}
	validates_presence_of :fechaEntrega, :presence => {:message => "no puede ser blanco"}
	validates_presence_of :fechaTope, :presence => {:message => "no puede ser blanco"}
	has_many :table_items_solicitud

end
