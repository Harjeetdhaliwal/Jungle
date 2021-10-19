class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false } 
  validates :password, length: { minimum: 5}
end
