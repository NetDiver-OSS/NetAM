# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.admin?

    user.permissions.each do |permission|
      unless permission.subject_id.nil?
        can permission.action.to_sym, permission.subject_class.constantize, id: permission.subject_id
        can permission.action.to_sym, Usage, section: { id: permission.subject_id }
        can permission.action.to_sym, Permission, subject_class: 'Section', subject_id: permission.subject_id
      end
    end
  end
end
