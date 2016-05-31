class CompaniesController < ApplicationController

	def index
		@companies = Company.all.decorate
	end

end
