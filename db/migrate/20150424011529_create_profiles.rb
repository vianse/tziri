class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :nombre
      t.string :puesto
      t.string :movil
      t.string :user_id

      t.timestamps
    end
  end
end
