class RemoveFullNameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :Full_name, :string
  end
end
