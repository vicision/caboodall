class Item < ActiveRecord::Base
  belongs_to :user
  has_many :item_types
  has_many :types, through: :item_types

end
