class User < ApplicationRecord
  before_save { email.downcase! } # same as self.email = self.email.downcase or self.email = email.downcase
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: {case_sensitive: false},
                    length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  has_secure_password

  validates :password, presence: true, length: { minimum: 8 }
end
