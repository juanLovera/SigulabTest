class Relation < ActiveRecord::Base
  Tipo = ['Equipo', 'Material consumible', 'Servicio de mantenimiento de equipos', 'Licencias', 'Repuesto', 'Renovacion de licencias', 'Accesorio', 'Otro']
  belongs_to :user
end
