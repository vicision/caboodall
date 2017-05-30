class User < ActiveRecord::Base
  has_many :types
  has_many :items

  has_secure_password
  validates :username, :email, presence: true, uniqueness: true

  def slug
    username.downcase.strip.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find do |u|
      u.slug == slug
    end
  end

end
