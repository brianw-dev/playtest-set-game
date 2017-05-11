class User < ApplicationRecord
  require 'bcrypt'

  has_secure_password

  validates :first_name, :last_name, :username, :email, presence: true
  has_many :games

end
