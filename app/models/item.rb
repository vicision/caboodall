class Item < ActiveRecord::Base
  has_many :user_items
  has_many :users, through: :user_items
  has_many :item_types
  has_many :types, through: :item_types

end
