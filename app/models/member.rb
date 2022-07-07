class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,                    dependent: :destroy
  has_many :post_comments,            dependent: :destroy
  has_many :likes,                    dependent: :destroy

  has_many :relationships,           class_name: 'Relationship',
                                    foreign_key: 'follower_id',
                                      dependent: :destroy

  has_many :reverse_of_relationships,class_name: 'Relationship',
                                    foreign_key: 'followed_id',
                                      dependent: :destroy

  has_many :followings,               through: :relationships,
                                       source: :followed

  has_many :followers,                 through: :reverse_of_relationships,
                                       source: :follower


  validates :last_name,     presence: true
  validates :first_name,    presence: true
  validates :nickname,      presence: true

  def full_name
    last_name + " "  + first_name
  end

  def follow(member_id)
    relationships.create(followed_id: member_id)
  end

  def unfollow(member_id)
    relationships.find_by(followed_id: member_id).destroy
  end

  def following?(member)
    followings.include?(member)
  end

end
