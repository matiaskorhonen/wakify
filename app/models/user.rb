class User < ActiveRecord::Base
  has_many :computers
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation
  
  attr_accessor :password
  before_save :prepare_password
  before_create :add_activation_code
  
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => false, :case_sensitive => false
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => false, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  
  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end
  
  def self.computers
    return Computer.find_by_user_id(self.id)
  end
  
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end
  
  def activated?
    self.activation_code.nil?
  end
  
  private
  
  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end
  
  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
  
  def add_activation_code
    self.activation_code = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
