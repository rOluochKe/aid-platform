class AddUserRefToVolunteers < ActiveRecord::Migration[6.0]
  def change
    add_reference :volunteers, :user, foreign_key: true
  end
end
