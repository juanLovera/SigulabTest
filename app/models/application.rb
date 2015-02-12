class Application < ActiveRecord::Base
	validates_presence_of :descripcion
	validates_presence_of :fechaRequerida
	validates_presence_of :uso
end
