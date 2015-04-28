class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nombre
      t.string :codigo

      t.timestamps
    end
  end
end
