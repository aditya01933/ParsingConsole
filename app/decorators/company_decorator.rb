class CompanyDecorator < Draper::Decorator
  delegate_all

  def number_of_operations
  	operations.count
  end

  def average_of_amount
  	operations.average(:amount) || 0
  end

  def highest_of_month
  	operations.where("created_at >= ?", Time.zone.now.beginning_of_month).maximum("amount") || 0
	end

end
