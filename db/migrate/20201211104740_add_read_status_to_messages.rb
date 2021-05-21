class AddReadStatusToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :read_status, :integer, :default => 0
  end
end
