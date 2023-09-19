class Enquiry < ApplicationRecord

  belongs_to :customer, optional: true

  validates :title, :detail, presence: true

end
