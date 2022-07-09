class Post < ApplicationRecord

  enum status: { published: 0, draft: 1 }

  belongs_to  :member
  has_many    :post_comments,         dependent: :destroy
  has_many    :likes,                 dependent: :destroy

  validates :title, length: { maximum: 50 },  presence: true
  validates :content,                         presence: true

  def liked_by?(member)
     likes.exists?(member_id: member.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    else
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end

end
