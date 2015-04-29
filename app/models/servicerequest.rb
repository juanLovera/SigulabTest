class Servicerequest < ActiveRecord::Base
	validates_presence_of :seccion
	belongs_to :user
end
