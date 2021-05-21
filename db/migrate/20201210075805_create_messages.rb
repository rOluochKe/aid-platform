class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :receiver_id
      t.text :content
      t.belongs_to :user
      t.belongs_to :request

      t.timestamps
    end
  end
end
