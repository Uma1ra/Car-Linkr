class Car < ApplicationRecord

  has_many_attached :images

  has_many :car_genres, dependent: :destroy
  has_many :subgenres, through: :car_genres
  has_many :buy_requests

  validates :name,
            :color,
            :passenger_amount,
            :year,
            :chassis_code,
            :mileage,
            :shaken_period,
            :grade,
            :engine_capacity,
            :transmission,
            :fuel,
  presence: true

  validates :name, uniqueness: true
  validates :price, :passenger_amount, :mileage, numericality: {greater_than_or_equal_to: 0}


  # 画像が存在する場合、最初の画像を取得
  def first_image
    unless images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    return images.first
  end


  # 消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

  # 車検期間
  enum shaken_period: {no_shaken: 0, six_months: 1, one_year: 2, two_years: 3}
  # ミッションの種類
  enum transmission: {automatic: 0, four_mt: 1, five_mt: 2, six_mt: 3, other_t: 3}
  # 使用燃料の種類
  enum fuel: {gasoline: 0, diesel: 1, electric: 2, other_f: 3}

  # 検索メソッド
  def self.search(search)
    if search != ""
      self.joins(:subgenres).where([
                "cars.name LIKE(?)
                OR cars.id LIKE(?)
                OR cars.detail LIKE(?)
                OR cars.color LIKE(?)
                OR cars.year LIKE(?)
                OR cars.chassis_code LIKE(?)
                OR cars.grade LIKE(?)
                OR cars.engine_capacity LIKE(?)
                OR cars.transmission LIKE(?)
                OR cars.fuel LIKE(?)
                OR subgenres.name LIKE (?)",
                "%#{search}%",
                "%#{search}%",
                "%#{search}%",
                "%#{search}%",
                "%#{search}%",
                "%#{search}%",
                "%#{search}%",
                "%#{search}%",
                "%#{search}%",
                "%#{search}%",
                "%#{search}%"
                ]).group("cars.id")
    else
      Car.all
    end
  end

end
