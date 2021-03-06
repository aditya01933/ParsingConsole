class Operation < ActiveRecord::Base
  belongs_to :company

  has_many :category_operations
  has_many :categories, through: :category_operations

  validates_presence_of :invoice_num, :invoice_date, :amount, :operation_date, :kind, :status
  validates_numericality_of :amount, greater_than: 0
  validates_uniqueness_of :invoice_num

  validates :company_id, presence: { message: "not found" } 

  def self.to_csv
	  CSV.generate do |csv|	  	
	  	column_names.insert(0,"company") unless column_names.include?("company")
	  	new_column = column_names - ["id", "created_at", "updated_at", "company_id"]
	    csv << new_column
	    all.each do |result|	    	
	      csv << result.attributes.values_at(*column_names - ["company","id", "created_at", "updated_at", "company_id"] ).insert(0, result.company.name)
	    end

	  end
  end


end
