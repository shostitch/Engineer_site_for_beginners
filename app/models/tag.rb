class Tag < ApplicationRecord

  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :tag_name ,presence: true, uniqueness: true

end
