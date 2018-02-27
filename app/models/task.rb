class Task < ApplicationRecord
	belongs_to :user
	belongs_to :tasktype
	belongs_to :teamlead, optional: true
	belongs_to :requirent
	has_many   :attachements
end
