class Recipe < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'

  has_many :recipe_foods
  has_many :foods, through: :recipe_foods
end