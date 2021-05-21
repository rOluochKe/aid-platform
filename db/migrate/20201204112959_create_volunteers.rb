class CreateVolunteers < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteers do |t|
      t.integer :requester_id
      t.integer :volunteer_id
      t.belongs_to :request
      
      t.timestamps
    end
  end
end
