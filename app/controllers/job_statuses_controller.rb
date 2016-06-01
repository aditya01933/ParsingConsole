class JobStatusesController < ApplicationController
	def index
		if params["time"].present?
			@job = JobStatus.last
			respond_to do |format|
			  format.js			 
			end
		end
		
	end


end
