class User < ApplicationRecord
    validates :Full_name, presence: true
    validates :username, presence: true
    validates :password, presence: true
    validates :role, presence: true, inclusion: {in: %w(user admin),
      message: "valid role should be in (user, admin).%{value} is not a valid role."}
end
