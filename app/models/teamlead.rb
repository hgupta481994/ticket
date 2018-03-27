class Teamlead < ApplicationRecord
	has_many :users
	has_many :tasks
	has_many :requirements
end

# Team lead table does not have admin in it
# It has user_id that tells manager of the respective team lead.