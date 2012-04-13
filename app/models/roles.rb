class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, :through => :user_roles
end

class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
end