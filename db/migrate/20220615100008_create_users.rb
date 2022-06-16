class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :Full_name
      t.string :username
      t.string :password
      t.string :role

      t.timestamps
    end
  end
end
