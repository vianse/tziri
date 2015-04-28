class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :codigo_evento
      t.string :nombre
      t.string :puesto
      t.string :correo
      t.string :nombre_evento

      t.timestamps
    end
  end
end
