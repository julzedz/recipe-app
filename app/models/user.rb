class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  has_many :foods, foreign_key: 'user_id', dependent: :destroy
  has_many :recipes, dependent: :destroy

  validates :name, presence: true
end
