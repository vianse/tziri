class Checkin < ActiveRecord::Base
	attr_accessible :codigo_evento, :nombre, :puesto,:correo,:nombre_evento, :evento_id, :empresa
	belongs_to :evento
end
