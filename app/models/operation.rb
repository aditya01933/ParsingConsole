class Operation < ActiveRecord::Base
  belongs_to :company

  has_many :category_operations
  has_many :categories, through: :category_operations

  validates_presence_of :invoice_num, :invoice_date, :amount, :operation_date, :kind, :status
  validates_numericality_of :amount, greater_than: 0
  validates_uniqueness_of :invoice_num

  attr_accessor :file

  def custom_save
    if imported_operations.all?(&:valid?)
      imported_operations.each do |t|        
        t.save!
      end
      true
    else
      imported_operations.each_with_index do |product, index|
        unless product.valid?
          product.errors.full_messages.each do |message|
            errors.add :base, "Row #{index+2}: #{message}"
          end
        end  
      end
      false
    end
  end

  def imported_operations
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
   
	  (2..spreadsheet.last_row).map do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	   
	    company = Company.find_by(name: row["company"])
	    operation = Operation.new
	    
	    operation.attributes = row.except("company", nil)
	    company.operations << operation 
	    operation       
	  end    
	end

  def open_spreadsheet    
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    # when ".xls" then Roo::Excel.new(file[:file].path, file_warning: :ignore)
    # when ".xlsx" then Roo::Excelx.new(file[:file].path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end


end
