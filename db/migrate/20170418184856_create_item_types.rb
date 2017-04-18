class CreateItemTypes < ActiveRecord::Migration
  def change
    create_table :item_types do |t|
      t.integer :item_id
      t.integer :type_id
    end
  end
end
