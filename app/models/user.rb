class User < ActiveRecord::Base
  has_many :boards

  validates_presence_of :name, :email
  #, :password_hash, :password_digest, :location
  # commenting these out until figure out how we are handling auth
  # might just use has_secure_password (see Gemfile re: BCrypt)
end
