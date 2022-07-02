class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :family_name
      t.date :birthday_date
      t.date :hiring_date
      t.string :photo_profile
      t.float :net_salary

      t.timestamps
    end
  end
end
