class AddStartTimeToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :start_time, :datetime, :default => DateTime.now
  end
end
