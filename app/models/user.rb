class User < ActiveRecord::Base
  has_many :user_items
  has_many :items, through: :user_items
  has_many :types, through: :items
  has_secure_password

  def slug
    username.downcase.strip.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find do |u|
      u.slug == slug
    end
  end

end
