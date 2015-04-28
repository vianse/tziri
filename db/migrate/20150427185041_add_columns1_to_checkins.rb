class AddColumns1ToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :Evento_id, :integer
  end
end
