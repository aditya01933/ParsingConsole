class JobStatusesController < ApplicationController
	def index	
		@job_id = params["job_id"]
		if params["time"].present?
			@job = JobStatus.where('created_at >= ? and job_id = ?', params["time"].to_time, @job_id)
			respond_to do |format|
			  format.js			 
			end
		end
		
	end


end
