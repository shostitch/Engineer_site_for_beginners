class Post < ApplicationRecord

  belongs_to  :member
  has_many    :post_comments,             dependent: :destroy
  has_many    :likes,                     dependent: :destroy
  has_many    :post_tags,                 dependent: :destroy     
  has_many    :tags, through: :post_tags, dependent: :destroy

end
