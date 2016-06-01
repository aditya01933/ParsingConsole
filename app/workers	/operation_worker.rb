class OperationWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	  def perform(file_path, file_name)	  

	    spreadsheet = Roo::CSV.new(file_path)
	    header = spreadsheet.row(1)   
		  (2..spreadsheet.last_row).map do |i|
		    row = Hash[[header, spreadsheet.row(i)].transpose] 	  	 
		  	operation = add_company(row)
		  	if operation.valid?
		  		operation.save!
		  		JobStatus.create(job_id: self.jid, message: "row #{i} successfully imported")
		  	else
		  		JobStatus.create(job_id: self.jid, message: "error #{operation.errors.full_messages} in row #{i}")
		  		
		  		operation.errors.full_messages
		  	end	
		  end

	  end

	  private

	  def add_company(row)
	  	operation = Operation.new
	  	company = Company.find_by(name: row["company"])
	  	operation.attributes = row.except("company", nil)  
	  	if company.nil?
	  	  operation
	  	else
	  	  company.operations.build(row.except("company", nil).merge(company_id: company.id))
	  	end
	  end

end