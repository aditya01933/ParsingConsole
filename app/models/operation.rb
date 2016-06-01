class Operation < ActiveRecord::Base
  belongs_to :company

  has_many :category_operations
  has_many :categories, through: :category_operations

  validates_presence_of :invoice_num, :invoice_date, :amount, :operation_date, :kind, :status
  validates_numericality_of :amount, greater_than: 0
  validates_uniqueness_of :invoice_num

  validates :company_id, presence: { message: "not found" }

  attr_accessor :file_path, :file_name 

  def custom_save
    if imported_operations.all?(&:valid?)
      imported_operations.each do |t| 
        t.save!
        category_array = t.kind.split("; ")
        category_array.each do |name|
          category = Category.find_or_create_by(name: name) 
          t.categories << category      
        end
        true        	    
      end      
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
	  	add_company(row)
	  end    
	end

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

 

  def open_spreadsheet    
    case File.extname(file_name)
    when ".csv" then Roo::CSV.new(file_path)
    # when ".xls" then Roo::Excel.new(file[:file].path, file_warning: :ignore)
    # when ".xlsx" then Roo::Excelx.new(file[:file].path)
    else raise "Unknown file type: #{file_name}"
    end
  end


end
