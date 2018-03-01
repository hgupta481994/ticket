class Task < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :tasktype
	belongs_to :teamlead
	belongs_to :requirement
	has_many   :attachements
end
