class User < ApplicationRecord
  has_secure_password
  belongs_to :employee
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password, presence: true
  validates :role, presence: true, inclusion: { in: %w[user admin],
                                                message: 'valid role should be in (user, admin).\
      %<value> is not a valid role.' }
  validates :employee_id, uniqueness: true
end
