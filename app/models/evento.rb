class Evento < ActiveRecord::Base
	attr_accessible :nombre, :codigo, :user_id
	has_many :checkins
end
