class Tasktype < ApplicationRecord
	has_many :tasks
end

=begin

***Task Type***
tasktype_id | Type
1-			Issue
2-			Change Request
3-			Emhancement
=end