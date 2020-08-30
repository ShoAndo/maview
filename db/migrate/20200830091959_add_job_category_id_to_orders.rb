class AddJobCategoryIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :job_category_id, :integer
  end
end
