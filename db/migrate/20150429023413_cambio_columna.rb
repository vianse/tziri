class CambioColumna < ActiveRecord::Migration
  def change
  	rename_column :checkins, :Evento_id, :evento_id
  end
end
