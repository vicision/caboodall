class Type < ActiveRecord::Base
  has_many :items
  belongs_to :user

  def slug
    name.downcase.strip.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Type.all.find do |t|
      t.slug == slug
    end
  end

end
