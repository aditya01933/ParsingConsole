class CreateJobStatuses < ActiveRecord::Migration
  def change
    create_table :job_statuses do |t|
      t.integer :job_id
      t.string :message

      t.timestamps null: false
    end
  end
end
