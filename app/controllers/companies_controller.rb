class CompaniesController < ApplicationController
	

	def index
		 @operations = Operation.new	 
		@companies = Company.all.page(params[:page]).per(1)
	end

	


	# private
	# 	def company_params	
	# 		params.permit(:company).require(:name)	
	# 	end	
end
