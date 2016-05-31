class CreateCategoryOperations < ActiveRecord::Migration
  def change
    create_table :category_operations do |t|
      t.references :category
      t.references :operation

      t.timestamps null: false
    end
  end
end
