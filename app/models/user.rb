class User < ApplicationRecord
  belongs_to :employee
  validates :username, presence: true
  validates :username, uniqueness: { scope: :password }
  validates :password, presence: true
  validates :role, presence: true, inclusion: { in: %w[user admin],
                                                message: 'valid role should be in (user, admin).\
      %<value> is not a valid role.' }
end
