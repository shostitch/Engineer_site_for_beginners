class Tag < ApplicationRecord

  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :tag_name ,presence: true, uniqueness: true

  def self.tag_order(order)
    self.joins(:post_tags).group(:tag_name).select('tags.id, tags.tag_name, count(tag_name) AS tag_count').order("tag_count #{order}")
  end

end
