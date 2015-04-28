class Profile < ActiveRecord::Base
	  attr_accessible :nombre, :puesto, :movil,:user_id
end
