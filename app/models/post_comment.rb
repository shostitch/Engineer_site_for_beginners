class PostComment < ApplicationRecord

  validates :comment, presence: true

  belongs_to :member
  belongs_to :post

end
