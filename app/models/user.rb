class User < ApplicationRecord
  require 'BCrypt'

  has_secure_password
end
