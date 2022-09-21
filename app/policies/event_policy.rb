class EventPolicy < ApplicationPolicy
  def show?
    # record.pincode.blank? || user.try(:author?, record)
  end

  def create?
    user.present?
  end

  def update?
    user.try(:author?, record)
  end

  def destroy?
    user.try(:author?, record)
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
