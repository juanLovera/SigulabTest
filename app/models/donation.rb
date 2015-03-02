class Donation < ActiveRecord::Base
<<<<<<< HEAD
	validates_presence_of :nombreItem

=======
	validates :nombreItem, :presence => {:message => "no puede ser blanco"}
	validates :cantidad, :presence => {:message => "no puede ser blanco"}
	validates :unidadMedida, :presence => {:message => "no puede ser blanco"}
	validates :estimado, :presence => {:message => "no puede ser blanco"}
	validates :numDocumento, :presence => {:message => "no puede ser blanco"}
>>>>>>> 60a085223ec7d1d0d647919822d76302d8538ff1
end
