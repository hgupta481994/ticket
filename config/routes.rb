Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, 	 :controllers => { :registrations => 'users/registrations', :sessions =>'users/sessions' }
  root "home#index"
  get 'home' => 'home#index'

  get 'admin/teamlead' => 'admin#teamlead'
  get 'admin/developers' => 'admin#developer'
  get 'admin/tester' => 'admin#tester'

  get 'make_task_tl/:id' => 'teamlead#make_task_tl', as: :make_task_tl

  resources :requirement
  patch 'admin/make_teamlead/:id' => 'admin#make_teamlead', as: :make_teamlead
  delete 'admin/employee/:id' => 'employee#destroy',        as: :admin_employee

  resources :task

  resources :teamlead, only: [:tl_assign_to_multiple] do
    collection do
      put :tl_assign_to_multiple
    end
  end
  get 'add_task/:id' => 'teamlead#add_task', as: :add_task
  
end
