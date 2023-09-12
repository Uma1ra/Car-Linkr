class Subgenre < ApplicationRecord
  
  belongs_to :genre
  
  validates :name, presence: true, uniqueness: true
  
end
