class OperationsController < ApplicationController
	require 'roo'
	def index
	  @operations = Operation.new	  
	end

	def create
		
	  @operations = Operation.new(file: operation_params[:file])
	 
	  if @operations.custom_save
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