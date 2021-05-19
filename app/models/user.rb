class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: :Relationship, foreign_key: :follower_id, dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: :Relationship, foreign_key: :followed_id, dependent: :destroy

  has_many :followers, through: :passive_relationships

  attr_accessor :remember_token

  before_save { email.downcase! } # same as self.email = self.email.downcase or self.email = email.downcase
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  class << self
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  def authenticated?(remember_token)
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def session_token
    remember_digest || remember
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    following_ids_subset = "SELECT followed_id FROM relationships 
    WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids_subset}) OR user_id = :user_id",user_id:id).includes(:user, image_attachment: :blob)
  end

  def follows(other_user)
    following << other_user
  end

  def unfollows(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
