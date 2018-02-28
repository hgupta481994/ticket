class Task < ApplicationRecord
	belongs_to :user
	belongs_to :tasktype
	belongs_to :teamlead, optional: true
	belongs_to :requirement
	has_many   :attachements
end
