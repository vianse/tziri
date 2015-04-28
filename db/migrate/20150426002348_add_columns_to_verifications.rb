class AddColumnsToVerifications < ActiveRecord::Migration
  def change
    add_column :verifications, :movil, :string
  end
end
