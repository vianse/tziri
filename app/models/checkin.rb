class Checkin < ActiveRecord::Base
	attr_accessible :codigo_evento, :nombre, :puesto,:correo,:nombre_evento, :Evento_id
	belongs_to :eventos
end
