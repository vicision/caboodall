class Item < ActiveRecord::Base
  has_many :types
  # has_many :users, through: :items

end
