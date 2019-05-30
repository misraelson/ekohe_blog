class User < ApplicationRecord
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:admin, :author], multiple: false)                                      ##
  ############################################################################################ 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         validates_presence_of :name

  has_many :blogs, dependent: :destroy

  # set default user role
  after_create :set_role

  def set_role
    self.roles = 'author'
  end
  
  def first_name
    self.name.split.first
  end

  def last_name
    self.name.split.last
  end
end
