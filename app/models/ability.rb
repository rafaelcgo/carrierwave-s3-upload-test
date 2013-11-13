class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    guest
  end

  def guest
    can :manage, :all
  end
end
