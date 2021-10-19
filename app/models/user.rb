class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false } 
  validates :password, presence: true, length: { minimum: 5}
  validates :password_confirmation, presence: true, length: { minimum: 5}
  
  before_save :before_save

  def before_save
    self.email.downcase!
  end 

  def self.authenticate_with_credentials(email, password)
    @caseInsesitiveEmail = email.downcase.strip
    user = User.find_by_email(@caseInsesitiveEmail)&.authenticate(password)
    user
  end
end
