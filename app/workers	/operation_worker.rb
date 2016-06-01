class OperationWorker
	include Sidekiq::Worker

	  def perform(file_path, file_name)
	  	@operations = Operation.new(file_path: file_path, file_name: file_name)	  	
	    @operations.custom_save
	  end

	
end