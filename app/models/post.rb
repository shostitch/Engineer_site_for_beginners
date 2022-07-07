class Post < ApplicationRecord

  belongs_to  :member
  has_many    :post_comments,         dependent: :destroy
  has_many    :likes,                 dependent: :destroy

  validates :title, length: { maximum: 50 },  presence: true
  validates :content,                         presence: true


  def liked_by?(member)
     likes.exists?(member_id: member.id)
  end

end
