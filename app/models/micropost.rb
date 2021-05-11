class Micropost < ApplicationRecord
  belongs_to :user, dependent: :destroy
  default_scope(Proc.new{ order(created_at: :desc) })
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140}

end
