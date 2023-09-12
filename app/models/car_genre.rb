class CarGenre < ApplicationRecord
  
  belongs_to :car
  belongs_to :genre
  
end
