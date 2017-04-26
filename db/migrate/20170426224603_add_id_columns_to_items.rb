class AddIdColumnsToItems < ActiveRecord::Migration
  def change
    add_column :items, :type_id, :integer
    add_column :items, :user_id, :integer
  end
end
