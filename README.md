# README


* Ruby version  - 2.5
* Rails version - 5.1.5

* Database used sqlite

* Database initialization
	Run commands
	 `rake db:seed`
	 `rake db:migrate`
 
 	..* Sign-up through different accounts as teamlead, developer and tester

..* **Features in this web app**

	..* Admin
	1. Admin can make developer and tester teamlead.
	2. Admin can make new projects.
	3. Admin can assign projects to teamlead.
	4. Admin can assign available developers and tester to teamlead.


	..* Team Lead
	1. Team Lead can make Tasks from projects assigned to him.
	2. Team lead can assign tasks to developers.
	3. After task is done he can assign that task to tester assigned to him.

	..* Developers
	1. He can mark task as done assigned to him.

	..* Tester
	1. He can mark task as reviewed assign to him.
