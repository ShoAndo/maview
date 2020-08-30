class RemoveJobCategoryIdToOrder < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :job_category_id
  end
end
