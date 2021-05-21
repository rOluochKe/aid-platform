class AddRepublishStatusToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :republish_status, :boolean, :default => false
  end
end
