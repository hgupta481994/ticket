class Task < ApplicationRecord

=begin
***Task Status***
status_id   | status
1-			Assigned
2- 			Marked
3-			On_review
4-			Reviewed
5-			Closed
6-			Reopened


***Task Type***
tasktype_id | Type
1-			Issue
2-			Change Request
3-			Enhancement
=end


	belongs_to :user, optional: true
	belongs_to :status, optional: true
	belongs_to :tasktype
	belongs_to :teamlead
	belongs_to :requirement
	has_many   :attachements

# *****************************************Task Status***********************
	def created?
		if self.status_id == nil
			return true
		else
			return false
		end
	end

	def assigned?
		if self.status_id == 1
			return true
		else
			return false
		end
	end

	def marked?
		if self.status_id == 2
			return true
		else
			return false
		end
	end

	def on_review?
		if self.status_id == 3
			return true
		else
			return false
		end
	end

	def reviewed?
		if self.status_id == 4
			return true
		else
			return false
		end
	end

	def closed?
		if self.status_id == 5
			return true
		else
			return false
		end
	end

	def reopened?
		if self.status_id == 6
			return true
		else
			return false
		end
	end
#***********

#****************************************Task type*******************************
	def of_issue?
		if self.tasktype_id == 1
			return true
		else
			return false
		end
	end

	def of_change_request?
		if self.tasktype_id == 2
			return true
		else
			return false
		end
	end

	def of_enhancement?
		if self.tasktype_id == 3
			return true
		else
			return false
		end
	end
#*******************************	

end
