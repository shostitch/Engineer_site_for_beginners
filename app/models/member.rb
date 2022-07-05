class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,          dependent: :destroy
  has_many :post_comments,  dependent: :destroy
  has_many :likes,          dependent: :destroy

  validates :last_name,     presence: true
  validates :first_name,    presence: true
  validates :nickname,      presence: true


  def full_name
    last_name + " "  + first_name
  end

end
