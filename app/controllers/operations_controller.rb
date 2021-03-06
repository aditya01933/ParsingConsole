class OperationsController < ApplicationController
	require 'roo'
	def index
	  @operations = Operation.new	  
	end

	def create		
	 	@job_id = OperationWorker.perform_async(operation_params["file"].path, operation_params["file"].original_filename)	  
	  redirect_to job_statuses_path(job_id: @job_id)	  
	end

	def operation_csv
		
		@operations = Operation.where(company_id: params[:company_id] )
		respond_to do |format|
	    format.html
	    format.csv { send_data @operations.to_csv }
	  end
	end

	private

	def operation_params
		params.require(:operation).permit(:file)
	end
end