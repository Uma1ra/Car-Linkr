class SellDetail < ApplicationRecord

  has_many_attached :sellimages

  belongs_to :sell_request

  validates :car_name,
            :chassis_no,
            :year,
            :chassis_code,
            :mileage,
            :shaken_period,
  presence: true

end
