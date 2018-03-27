class Requirement < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
 	serialize :avatar, JSON # If you use SQLite, add this line.
	
	belongs_to :teamlead
	has_many :tasks, dependent: :destroy
	has_and_belongs_to_many :users

	accepts_nested_attributes_for :tasks # not used but kept for future purpose
end
