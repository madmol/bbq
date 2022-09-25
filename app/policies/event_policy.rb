class EventPolicy < ApplicationPolicy
  def show?
    user_show?(record)
  end

  def create?
    user.present?
  end

  def update?
    user.try(:author?, record)
  end

  def destroy?
    update?
  end

  private

  def user_show?(event)
    event.pincode.blank? || (user.present? && user == event.try(:user)) ||
      event.pincode_valid?(cookies["events_#{event.id}_pincode"])
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
