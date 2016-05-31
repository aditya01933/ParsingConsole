class CompaniesController < ApplicationController
	

	def index
		@companies = Company.all.page(params[:page]).per(2)
	end

end
