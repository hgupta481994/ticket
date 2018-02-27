class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  has_many :members, :class_name => 'User', :foreign_key => 'teamlead_id'

  scope :developers, -> { where(usertype_id: 3) }

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "50x50>" }, :default_url => "/images/:style/missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	  def self.find_for_database_authentication(warden_conditions)
	      conditions = warden_conditions.dup
	      if login = conditions.delete(:login)
	        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
	        where(conditions.to_h).first
	      end
	  end

	  validate :validate_username

		def validate_username
		  if User.where(email: username).exists?
		    errors.add(:username, :invalid)
		  end
		end


		def is_admin?
		    if self.isadmin
		      return true
		    else
		      return false
		    end
	 	end


  has_many :tasks
  has_and_belongs_to_many :requirements
  belongs_to :teamlead, optional: true
  belongs_to :usertype

end
