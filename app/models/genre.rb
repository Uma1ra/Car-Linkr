class Genre < ApplicationRecord

  has_many :subgenres, dependent: :destroy

  validates :name, presence: true, uniqueness: true

end
