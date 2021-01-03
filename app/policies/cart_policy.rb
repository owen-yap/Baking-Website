class CartPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user
  end

  def update?
    true
  end

  def cart_payment?
    record.user == user
  end
end
