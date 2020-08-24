class CreateOutlines < ActiveRecord::Migration[6.0]
  def change
    create_table :outlines do |t|

      t.timestamps
      t.text :outline
    end
  end
end
