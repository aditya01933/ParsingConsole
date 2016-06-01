class OperationsController < ApplicationController
	require 'roo'
	def index
	  @operations = Operation.new	  
	end

	def create		
		
	 	OperationWorker.perform_async(operation_params["file"].path, operation_params["file"].original_filename)	

	  if true
	    redirect_to '/operations', notice: "Import successful."
	  else
	    render :index
	  end
	end

	private

	def operation_params
		params.require(:operation).permit(:file)
	end
end