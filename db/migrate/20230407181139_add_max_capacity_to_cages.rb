class AddMaxCapacityToCages < ActiveRecord::Migration[7.0]
  def change
    add_column :cages, :max_capacity, :integer, default: 4
  end
end
