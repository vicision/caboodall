class Type < ActiveRecord::Base
  has_many :item_types
  has_many :items, through: :item_types
  has_many :users, through: :items

end
