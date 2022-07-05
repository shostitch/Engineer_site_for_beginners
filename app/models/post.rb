class Post < ApplicationRecord

  belongs_to  :member
  has_many    :post_comments,             dependent: :destroy
  has_many    :likes,                     dependent: :destroy
  has_many    :post_tags,                 dependent: :destroy
  has_many    :tags, through: :post_tags, dependent: :destroy

  validates :title, length: { maximum: 50 },  presence: true
  validates :content,                         presence: true

end
