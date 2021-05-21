class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :title
      t.string :type
      t.text :description
      t.float :lat
      t.float :lng
      t.string :address
      t.integer :status
      t.belongs_to :user

      t.timestamps
    end
  end
end
