class Requirement < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	serialize :avatars, JSON
	belongs_to :teamlead
	has_many :tasks, dependent: :destroy
	has_and_belongs_to_many :users

	accepts_nested_attributes_for :tasks
end
