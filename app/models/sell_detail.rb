class SellDetail < ApplicationRecord

  has_many_attached :sell_images

  belongs_to :sell_request

  validates :car_name,
            :chassis_no,
            :year,
            :chassis_code,
            :mileage,
            :shaken_period,
  presence: true
  
  # 車検期間
  enum shaken_period: {no_shaken: 0, six_months: 1, one_year: 2, two_years: 3}

end
