class RenameTypeColumnInRequest < ActiveRecord::Migration[6.0]
  def change
    rename_column :requests, :type, :reqtype
  end
end
