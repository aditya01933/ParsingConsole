class JobStatusesController < ApplicationController
	def index
		if params["time"].present?
			@job = JobStatus.where('created_at >= ?', params["time"].to_time)
			respond_to do |format|
			  format.js			 
			end
		end
		
	end


end
