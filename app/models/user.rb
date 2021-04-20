class User < ApplicationRecord
  validates :name , presence: true, length:{maximum:50}
  VALID_EMAIL =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness:true, length: {maximum:255}
end
