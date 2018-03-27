class Usertype < ApplicationRecord
	has_many :users	
end

=begin
	
****User Type****
usertype_id | Type
1-			Admin
2-			Team Lead
3-			Developer
4-			Tester
=end