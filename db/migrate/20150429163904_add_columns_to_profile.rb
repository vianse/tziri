class AddColumnsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :empresa, :string
  end
end
