class Post < ApplicationRecord

  enum status: { published: 0, draft: 1 }

  belongs_to  :member
  has_many    :post_comments,             dependent: :destroy
  has_many    :likes,                     dependent: :destroy
  has_many    :post_tags,                 dependent: :destroy
  has_many    :tags,                      through: :post_tags

  validates :title,  presence: true, length: { maximum: 50 }
  validates :content,presence: true


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
      all.published.order(created_at: :DESC)
    elsif selection == 'old'
      all.published.order(created_at: :ASC)
    elsif selection == 'likes'
      find(Like.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    
    end
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.uniq.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.uniq.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end

  def post_published
    self.published.all
  end
end
