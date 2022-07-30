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
  validates :is_active,     inclusion: [true, false]
  validates :start_date,    presence: true


  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

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

  def guest?
    full_name != "guest member"
  end

  def guest_member
    full_name == "guest member"
  end

  def self.guest
    randam_num = rand(100)
    email = "guest#{randam_num}@example.com"

    find_or_create_by!(email: email) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.last_name = 'guest'
      member.first_name = 'member'
      member.nickname = 'ゲスト'
      member.start_date = '2022-02-22'
    end
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Member.where(nickname: content)
    else
      Member.where('nickname LIKE ?', '%' + content + '%')
    end
  end
end

