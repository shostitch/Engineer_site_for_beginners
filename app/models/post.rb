class Post < ApplicationRecord

  enum status: { published: 0, draft: 1 }

  belongs_to  :member
  has_many    :post_comments,             dependent: :destroy
  has_many    :likes,                     dependent: :destroy
  has_many    :post_tags,                 dependent: :destroy
  has_many    :posts,through: :post_tags

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

  def self.sort(selection)
    if selection == 'new'
      all.order(created_at: :DESC)
    elsif selection == 'old'
      all.order(created_at: :ASC)
    elsif selection == 'likes'
      find(Like.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    elsif selection == 'dislikes'
      find(Like.group(:post_id).order(Arel.sql('count(post_id) asc')).pluck(:post_id))
    end
  end

end
