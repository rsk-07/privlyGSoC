class User < ActiveRecord::Base
  
  has_many :posts, :dependent => :destroy
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :token_authenticatable, 
         :confirmable, :lockable, :timeoutable
  
  before_create :process_email
  
  validates :email,
           :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # ActiveAdmin permissions
  attr_accessible :alpha_invites, :beta_invites, :forever_account_value, :permissioned_requests_served, :nonpermissioned_requests_served, :as => :admin
  
  # Downcase the email and store the email's domain in a separate
  # column.
  def process_email
    self.email.downcase!
    self.domain = self.email.split("@")[1]
  end
  
  #prevents users from getting account access via
  #invitation system
  #https://github.com/scambra/devise_invitable/wiki/Disabling-devise-recoverable,-if-invitation-was-not-accepted
  def send_reset_password_instructions
    super if invitation_token.nil?
  end
  
end
