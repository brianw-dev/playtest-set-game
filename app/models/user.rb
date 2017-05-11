class User < ApplicationRecord
  require 'bcrypt'

  has_secure_password
end
