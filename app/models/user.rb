class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # By default any new user who register has teamlead_id: 1 
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable

  has_many :task_developers, :class_name => 'Task', :foreign_key => 'developer_id'
  has_many :task_testers,    :class_name => 'Task', :foreign_key => 'tester_id'
  
  has_and_belongs_to_many :requirements
  
  belongs_to :teamlead, optional: true
  belongs_to :usertype
  has_many   :notifications, dependent: :destroy
  has_many :members, :class_name => 'User', :foreign_key => 'teamlead_id' #If using team lead from User model rather than Teamlead model 

  scope :developers, -> { where(usertype_id: 3) } #Teamlead has developers under him who have usertype_id: 3
  scope :testers, -> { where(usertype_id: 4) }    #Teamlead has testers    under him who have usertype_id: 4                         

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "50x50>" }, :default_url => "/images/:style/missing.jpg" #profile pic

  attr_accessor :login   						  # attr_accessor for login

   #**********************************************validating format of username******************************
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true 
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validate :validate_username

    def validate_username
	  if User.where(email: username).exists?
	    errors.add(:username, :invalid)
	  end
	end
  #**********

	# *********************************Login either through amail or username case insensitive ******************
  	def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
	end
	#************
	
	# *******************************************User type**************************
	def is_admin?
	    if self.isadmin
	      return true
	    else
	      return false
	    end
 	end

 	def is_tlead?
	    if self.usertype_id == 2
	      return true
	    else
	      return false
	    end
 	end

 	def is_developer?
	    if self.usertype_id == 3
	      return true
	    else
	      return false
	    end
 	end

 	def is_tester?
	    if self.usertype_id == 4
	      return true
	    else
	      return false
	    end
 	end  
 	#*******************
end
