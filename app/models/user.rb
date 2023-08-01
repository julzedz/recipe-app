class User < ApplicationRecord
  has_many :food
  has_many :recipe

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
