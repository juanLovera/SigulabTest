class Devolution < ActiveRecord::Base
	validates_presence_of :unidadSolicitante
	belongs_to :user
end
