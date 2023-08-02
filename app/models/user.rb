class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :food, foreign_key: 'user_id'
  has_many :recipe
end
