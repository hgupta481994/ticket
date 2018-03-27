class Attachement < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	serialize :avatars, JSON
	
	belongs_to :task
end
