class Verification < ActiveRecord::Base
    validates_presence_of :phone_number, :code, :movil, :codigo_evento
    attr_accessible :phone_number, :code, :movil,:codigo_evento
end