class AddCompanyIdToOutline < ActiveRecord::Migration[6.0]
  def change
    add_reference :outlines, :company, null: false, foreign_key: true
  end
end
