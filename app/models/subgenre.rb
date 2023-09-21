class Subgenre < ApplicationRecord

  belongs_to :genre
  has_many :car_genres
  has_many :cars, through: :car_genres

  validates :name, presence: true, uniqueness: true

end
