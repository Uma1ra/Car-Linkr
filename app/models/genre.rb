class Genre < ApplicationRecord
  
  has_many :car_genres
  has_many :cars, through: :car_genres
  
  has_many :subgenres, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  
end
