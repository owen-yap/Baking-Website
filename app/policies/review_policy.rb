class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    record.order.user == user && !record.order.review.nil?
  end

  def create?
    record.order.user == user && Review.exists?(record.id) == false
  end

end
