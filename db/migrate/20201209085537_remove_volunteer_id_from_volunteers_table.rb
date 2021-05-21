class RemoveVolunteerIdFromVolunteersTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :volunteers, :volunteer_id
  end
end
