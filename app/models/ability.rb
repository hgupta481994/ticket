class Ability
  include CanCan::Ability

  def initialize(user)
     alias_action :create, :read, :update, :destroy, to: :crud
   
    user ||= User.new               # guest user (not logged in)    

    if user.present?                # for logged in users 
        can    [:update, :read], [Task, Attachement], user_id: user.id 
        can    :crud, Notification
        cannot :crud, [Usertype, Status, Tasktype ]
        #can :read, Requirement , user_id: user.id

        if user.is_admin?           # additional permissions for administrators
            can :manage, [User, Requirement, Task, Teamlead, Attachement, Notification]

        elsif user.is_tlead?        # permissions for Team Lead
            can [:crud, :close_task], [Task] , teamlead_id: User.find_by_username(user.username).id
            can :crud, Attachement
            can :read, [Requirement], teamlead_id: User.find_by_username(user.username).id
            can :read, User
            can :access, :teamlead

        elsif user.is_tester?       # permissions for Team Lead
            can :access, :tester

        elsif user.is_developer?    # permissions for Team Lead
            can :access, :developer
        end
    end
     


    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
