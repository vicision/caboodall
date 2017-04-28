class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :type

  def slug
    title.downcase.strip.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Item.all.find do |t|
      t.slug == slug
    end
  end

end
