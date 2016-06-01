class OperationsController < ApplicationController
	require 'roo'
	def index
	  @operations = Operation.new	  
	end

	def create		
		
	 	@job_id = OperationWorker.perform_async(operation_params["file"].path, operation_params["file"].original_filename)	  
	  redirect_to job_statuses_path(job_id: @job_id)
	  
	end

	private

	def operation_params
		params.require(:operation).permit(:file)
	end
end