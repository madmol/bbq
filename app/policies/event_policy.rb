class EventPolicy < ApplicationPolicy
  def show?
    true
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
    def resolve
      scope.all
    end
  end
end
