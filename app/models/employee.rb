class Employee < ApplicationRecord
  has_one :user
  validates :name, presence: true
  validates :family_name, presence: true
  validates :net_salary, numericality: { greater_than: 0 }
end
