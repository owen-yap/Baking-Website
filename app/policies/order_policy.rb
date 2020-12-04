class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    record.user == user || record.product.user == user
  end

  def edit?
    # order.user => buyer   order.product.user=>seller
    record.user == user || record.product.user == user
  end

  def update?
    record.user == user || record.product.user == user
  end

end
