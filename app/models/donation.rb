class Donation < ActiveRecord::Base
<<<<<<< HEAD
<<<<<<< HEAD
	validates_presence_of :nombreItem

=======
=======
>>>>>>> 60a085223ec7d1d0d647919822d76302d8538ff1
	validates :nombreItem, :presence => {:message => "no puede ser blanco"}
	validates :cantidad, :presence => {:message => "no puede ser blanco"}
	validates :unidadMedida, :presence => {:message => "no puede ser blanco"}
	validates :estimado, :presence => {:message => "no puede ser blanco"}
	validates :numDocumento, :presence => {:message => "no puede ser blanco"}
<<<<<<< HEAD
>>>>>>> 60a085223ec7d1d0d647919822d76302d8538ff1
=======
>>>>>>> 60a085223ec7d1d0d647919822d76302d8538ff1
end
