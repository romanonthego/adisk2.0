class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
  				# :registerable,
        	# :recoverable,
        	# :rememberable,
        	:trackable,
        	:validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation #, :remember_me

  validates :email, :presence => true
  validates :password, :presence => true, :confirmation => true, :length => {:minimum => 7}
end
