class AddColumnsToCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :empresa, :string
  end
end
