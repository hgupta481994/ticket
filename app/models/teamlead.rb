class Teamlead < ApplicationRecord
	has_many :users
	has_many :tasks
	has_many :requirements
end
