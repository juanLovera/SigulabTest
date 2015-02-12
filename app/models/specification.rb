class Specification < ActiveRecord::Base
        belongs_to :user
        has_many :acts
        Tipo = ['Bienes', 'Servicios']
end
