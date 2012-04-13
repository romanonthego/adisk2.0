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
  attr_accessible :email, 
                  :password, 
                  :password_confirmation,
                  :login, 
                  :remember_me, 
                  :first_name, 
                  :patronomic, 
                  :last_name,
                  :position,
                  :extension_number,
                  :cell_phone,
                  :icq,
                  :skype,
                  :city,
                  :comment,
                  :user_roles_attributes

  # Simple roles plugin - user have ine or many roles within has_many_througth association
  simple_roles


  # References

  # This is self reference block - user can HAVE another users as his posible subtituents
  # for user who IS substituent on the other hand - user for whom hi substitute appears as appointive
  # so it works with simple reflection - but not goes both ways (user1 is sub for user2, but u2 may not be a sub for u1
  # while he WILL be apoointive for u1)

  # Simple (well, not simple actualy, takes time to figure it out) self reference - user can have many over user as substituents
  # self join goes through model Deputy, sine i need some logic and attr be place in this middleware
  has_many :deputies, :foreign_key => "appointive_id" #, :include => :sub
  has_many :subs, :class_name => "User", :through => :deputies, :foreign_key => "appointive_id"

  # Tricky part: since i can not find a way to use a named scope for a assocition :trought i create a new one. It basicly the 
  # same deputy association, but with conditions.
  # Also i change it from has_many to has_one - while user can have multiply posible subs, he can only have 1 active substituent
  has_one :active_deputy, :class_name => "Deputy", :foreign_key => "appointive_id", :conditions => {:is_active => true}
  has_one :active_sub, :class_name => "User", :through => :active_deputy, :foreign_key => "appointive_id", :source => :sub

  # All the same but in the opposite way. Thats why i call it reverse_ .
  has_many :reverse_deputies, :class_name => "Deputy", :foreign_key => "sub_id"
  has_many :appointives, :class_name => "User", :through => :reverse_deputies, :foreign_key => "sub_id"

  # has_many back again. Why? User can accept substituenship from many user simultaneously.
  has_many :active_reverse_deputies, :class_name => "Deputy", :foreign_key => "sub_id", :conditions => {:is_active => true}
  has_many :active_appointives, :class_name => "User", :through => :active_reverse_deputies, :foreign_key => "sub_id", :source => :appointive


  # Need to accept atributes througth nested form
  accepts_nested_attributes_for :user_roles, :allow_destroy => true, :reject_if => lambda {|r| !r[:active]}


  # Validations
  validates :email, :presence => true
  validates :password, :presence => true, :confirmation => true, :length => {:minimum => 7}


  # Instance methods
  def full_name
    last_name + " " + first_name + " " + patronomic
  end

  def initials
    last_name + " " + first_name.first_letter + ". " + patronomic + "."
  end

  def activate_sub(user)
    # rise an exception if given user is not User class instance
    dep = deputies.where(:sub_id => user.id).first
    dep.is_active = true
    dep.save!
  end

  def user_and_active_appointives
    UsersArray.new(self)
  end

  private
  def asign_roles
    unless :roles.nil?
      roles = :roles
      add_role :user
    end
  end


  # Utility class for user acts as an array of users.
  class UsersArray < Array

    attr_reader :base
    include UsersArrayExtension

    def initialize *args
      @user = args.delete(args.first)
      super
      extend_with_active_appointives
    end

    private
    def extend_with_active_appointives
      self << @user
      self << @user.active_appointives
      self.flatten!
    end
  end
end

class Deputy < ActiveRecord::Base
  # References
  belongs_to :appointive, :class_name => "User"
  belongs_to :sub, :class_name => "User"

end
