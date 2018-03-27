# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#***************************************For Usertype************************************#
user = Usertype.new
user.utype= "admin"
user.save!

user = Usertype.new
user.utype= "teamlead"
user.save!

user = Usertype.new
user.utype= "developer"
user.save!

user = Usertype.new
user.utype= "tester"
user.save!

#***************************************For Task status**********************************#
status= Status.new
status.status = "Assigned"
status.save!
 
status= Status.new
status.status = "Marked"
status.save!
  
status= Status.new
status.status = "On_review"
status.save!

status= Status.new
status.status = "Reviewed"
status.save!

status= Status.new
status.status = "Closed"
status.save!

status= Status.new
status.status = "Reopened"
status.save!

#***************************************For Admin****************************************#
user = User.new
user.email = 'admin@admin.com'
user.password = '123456'
user.password_confirmation = '123456'
user.username = 'admin'
user.isadmin = true
user.usertype_id = 1
user.teamlead_id = 1
user.save!
