# frozen_string_literal: true

# User ApplicationRecord class
class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }
end
