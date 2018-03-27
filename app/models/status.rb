
class Status < ApplicationRecord
	has_many :tasks
end

=begin
***Task Status***
status_id   | status
1-			Assigned
2- 			Marked
3-			On-review
4-			Reviewed
5-			Closed
6-			Reopened
=end