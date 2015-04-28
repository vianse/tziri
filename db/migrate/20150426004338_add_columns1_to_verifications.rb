class AddColumns1ToVerifications < ActiveRecord::Migration
  def change
    add_column :verifications, :codigo_evento, :string
  end
end
