# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: ENV["ADMIN_EMAIL"], password: ENV["ADMIN_PASSWORD"])

# エンドユーザー
customer1 = Customer.find_or_create_by!(email: "customer1@example.com") do |customer|
  customer.last_name = "山田"
  customer.first_name = "太郎"
  customer.last_name_kana = "ヤマダ"
  customer.first_name_kana = "タロウ"
  customer.post_code = "1111111"
  customer.phone_number = "1111111111"
  customer.password = ENV["CUSTOMER_PASSWORD"]
end

customer2 = Customer.find_or_create_by!(email: "customer2@example.com") do |customer|
  customer.last_name = "山田"
  customer.first_name = "次郎"
  customer.last_name_kana = "ヤマダ"
  customer.first_name_kana = "ジロウ"
  customer.post_code = "2222222"
  customer.phone_number = "2222222222"
  customer.password = ENV["CUSTOMER_PASSWORD"]
end

customer3 = Customer.find_or_create_by!(email: "customer3@example.com") do |customer|
  customer.last_name = "山田"
  customer.first_name = "三郎"
  customer.last_name_kana = "ヤマダ"
  customer.first_name_kana = "サブロウ"
  customer.post_code = "3333333"
  customer.phone_number = "3333333333"
  customer.password = ENV["CUSTOMER_PASSWORD"]
end

customer4 = Customer.find_or_create_by!(email: "customer4@example.com") do |customer|
  customer.last_name = "山田"
  customer.first_name = "四郎"
  customer.last_name_kana = "ヤマダ"
  customer.first_name_kana = "シロウ"
  customer.post_code = "4444444"
  customer.phone_number = "4444444444"
  customer.password = ENV["CUSTOMER_PASSWORD"]
end

customer5 = Customer.find_or_create_by!(email: "customer5@example.com") do |customer|
  customer.last_name = "山田"
  customer.first_name = "五郎"
  customer.last_name_kana = "ヤマダ"
  customer.first_name_kana = "ゴロウ"
  customer.post_code = "5555555"
  customer.phone_number = "5555555555"
  customer.password = ENV["CUSTOMER_PASSWORD"]
end


# ジャンル
maker = Genre.find_or_create_by!(name: "メーカー")
bodytype = Genre.find_or_create_by!(name: "ボディタイプ")


# サブジャンル
# メーカー
maker1 = Subgenre.find_or_create_by!(genre_id: 1, name: "トヨタ")
maker2 = Subgenre.find_or_create_by!(genre_id: 1, name: "ホンダ")
maker3 = Subgenre.find_or_create_by!(genre_id: 1, name: "マツダ")
maker4 = Subgenre.find_or_create_by!(genre_id: 1, name: "BMW")
maker5= Subgenre.find_or_create_by!(genre_id: 1, name: "アウディ")
maker6 = Subgenre.find_or_create_by!(genre_id: 1, name: "ミニ")
# ボディタイプ
bodytype1 = Subgenre.find_or_create_by!(genre_id: 2, name: "ハッチバック")
bodytype2 = Subgenre.find_or_create_by!(genre_id: 2, name: "セダン")
bodytype3 = Subgenre.find_or_create_by!(genre_id: 2, name: "軽トラ")
bodytype4 = Subgenre.find_or_create_by!(genre_id: 2, name: "ミニバン")
bodytype5 = Subgenre.find_or_create_by!(genre_id: 2, name: "軽自動車")
bodytype6 = Subgenre.find_or_create_by!(genre_id: 2, name: "オープン")


# 車
car1 = Car.find_or_create_by!(name: "プリウス") do |car|
  car.detail = "純正ホイールキャップ/ナビ/ETC/シートヒーター"
  car.price = "1200000"
  car.color = "白"
  car.passenger_amount = "1"
  car.year = Date.new(2018,11,1)
  car.chassis_code = "DAA-HNV23"
  car.mileage = "13870"
  car.shaken_period = 0
  car.shaken_finish = ""
  car.grade = "X"
  car.engine_capacity = "2400cc"
  car.transmission = 0
  car.fuel = 0
  car.is_available = true
  car.images = [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red(1).jpg"), filename:"red(1).jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/white(1).jpg"), filename:"white(1).jpg")]
end

car2 = Car.find_or_create_by!(name: "フィット") do |car|
  car.detail = "純正ホイールキャップ/ナビ/ETC/シートヒーター"
  car.price = "1200000"
  car.color = "白"
  car.passenger_amount = "1"
  car.year = Date.new(2018,11,1)
  car.chassis_code = "DAA-HNV23"
  car.mileage = "13870"
  car.shaken_period = 0
  car.shaken_finish = ""
  car.grade = "X"
  car.engine_capacity = "2400cc"
  car.transmission = 0
  car.fuel = 0
  car.is_available = true
  car.images = [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red(1).jpg"), filename:"red(1).jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/white(1).jpg"), filename:"white(1).jpg")]
end

car3 = Car.find_or_create_by!(name: "ラパン") do |car|
  car.detail = "純正ホイールキャップ/ナビ/ETC/シートヒーター"
  car.price = "1200000"
  car.color = "白"
  car.passenger_amount = "1"
  car.year = Date.new(2018,11,1)
  car.chassis_code = "DAA-HNV23"
  car.mileage = "13870"
  car.shaken_period = 0
  car.shaken_finish = ""
  car.grade = "X"
  car.engine_capacity = "2400cc"
  car.transmission = 0
  car.fuel = 0
  car.is_available = true
  car.images = [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red(1).jpg"), filename:"red(1).jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/white(1).jpg"), filename:"white(1).jpg")]
end

car4 = Car.find_or_create_by!(name: "ヴィッツ") do |car|
  car.detail = "純正ホイールキャップ/ナビ/ETC/シートヒーター"
  car.price = "1200000"
  car.color = "黒"
  car.passenger_amount = "1"
  car.year = Date.new(2018,11,1)
  car.chassis_code = "DAA-HNV23"
  car.mileage = "13870"
  car.shaken_period = 0
  car.shaken_finish = ""
  car.grade = "X"
  car.engine_capacity = "2400cc"
  car.transmission = 0
  car.fuel = 0
  car.is_available = true
  car.images = [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red(1).jpg"), filename:"red(1).jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/white(1).jpg"), filename:"white(1).jpg")]
end

car5 = Car.find_or_create_by!(name: "アクア") do |car|
  car.detail = "純正ホイールキャップ/ナビ/ETC/シートヒーター"
  car.price = "1200000"
  car.color = "白"
  car.passenger_amount = "1"
  car.year = Date.new(2018,11,1)
  car.chassis_code = "DAA-HNV23"
  car.mileage = "13870"
  car.shaken_period = 0
  car.shaken_finish = ""
  car.grade = "X"
  car.engine_capacity = "2400cc"
  car.transmission = 0
  car.fuel = 0
  car.is_available = true
  car.images = [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red(1).jpg"), filename:"red(1).jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/white(1).jpg"), filename:"white(1).jpg")]
end

car6 = Car.find_or_create_by!(name: "クーパー") do |car|
  car.detail = "純正ホイールキャップ/ナビ/ETC/シートヒーター"
  car.price = "1200000"
  car.color = "白"
  car.passenger_amount = "1"
  car.year = Date.new(2018,11,1)
  car.chassis_code = "DAA-HNV23"
  car.mileage = "13870"
  car.shaken_period = 0
  car.shaken_finish = ""
  car.grade = "X"
  car.engine_capacity = "2400cc"
  car.transmission = 0
  car.fuel = 0
  car.is_available = true
  car.images = [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red(1).jpg"), filename:"red(1).jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/white(1).jpg"), filename:"white(1).jpg")]
end

car7 = Car.find_or_create_by!(name: "ジムニー") do |car|
  car.detail = "純正ホイールキャップ/ナビ/ETC/シートヒーター"
  car.price = "1200000"
  car.color = "白"
  car.passenger_amount = "1"
  car.year = Date.new(2018,11,1)
  car.chassis_code = "DAA-HNV23"
  car.mileage = "13870"
  car.shaken_period = 0
  car.shaken_finish = ""
  car.grade = "X"
  car.engine_capacity = "2400cc"
  car.transmission = 0
  car.fuel = 0
  car.is_available = true
  car.images = [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red(1).jpg"), filename:"red(1).jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/white(1).jpg"), filename:"white(1).jpg")]
end

car8 = Car.find_or_create_by!(name: "X1") do |car|
  car.detail = "純正ホイールキャップ/ナビ/ETC/シートヒーター"
  car.price = "1200000"
  car.color = "白"
  car.passenger_amount = "1"
  car.year = Date.new(2018,11,1)
  car.chassis_code = "DAA-HNV23"
  car.mileage = "13870"
  car.shaken_period = 0
  car.shaken_finish = ""
  car.grade = "X"
  car.engine_capacity = "2400cc"
  car.transmission = 0
  car.fuel = 0
  car.is_available = true
  car.images = [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red(1).jpg"), filename:"red(1).jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/white(1).jpg"), filename:"white(1).jpg")]
end

car9 = Car.find_or_create_by!(name: "T T クーペ") do |car|
  car.detail = "純正ホイールキャップ/ナビ/ETC/シートヒーター"
  car.price = "1200000"
  car.color = "白"
  car.passenger_amount = "1"
  car.year = Date.new(2018,11,1)
  car.chassis_code = "DAA-HNV23"
  car.mileage = "13870"
  car.shaken_period = 0
  car.shaken_finish = ""
  car.grade = "X"
  car.engine_capacity = "2400cc"
  car.transmission = 0
  car.fuel = 0
  car.is_available = false
  car.images = [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red(1).jpg"), filename:"red(1).jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/white(1).jpg"), filename:"white(1).jpg")]
end

car10 = Car.find_or_create_by!(name: "デミオ") do |car|
  car.detail = "純正ホイールキャップ/ナビ/ETC/シートヒーター"
  car.price = "1200000"
  car.color = "青"
  car.passenger_amount = "1"
  car.year = Date.new(2018,11,1)
  car.chassis_code = "DAA-HNV90"
  car.mileage = "34870"
  car.shaken_period = 0
  car.shaken_finish = ""
  car.grade = "X"
  car.engine_capacity = "2400cc"
  car.transmission = 0
  car.fuel = 0
  car.is_available = true
  car.images = [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/red(1).jpg"), filename:"red(1).jpg"), ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/white(1).jpg"), filename:"white(1).jpg")]
end

CarGenre.find_or_create_by!(car_id: car1.id, subgenre_id: maker1.id)
CarGenre.find_or_create_by!(car_id: car1.id, subgenre_id: bodytype1.id)
CarGenre.find_or_create_by!(car_id: car2.id, subgenre_id: maker2.id)
CarGenre.find_or_create_by!(car_id: car2.id, subgenre_id: bodytype2.id)
CarGenre.find_or_create_by!(car_id: car3.id, subgenre_id: maker3.id)
CarGenre.find_or_create_by!(car_id: car3.id, subgenre_id: bodytype3.id)
CarGenre.find_or_create_by!(car_id: car4.id, subgenre_id: maker4.id)
CarGenre.find_or_create_by!(car_id: car4.id, subgenre_id: bodytype4.id)
CarGenre.find_or_create_by!(car_id: car5.id, subgenre_id: maker5.id)
CarGenre.find_or_create_by!(car_id: car5.id, subgenre_id: bodytype5.id)
CarGenre.find_or_create_by!(car_id: car6.id, subgenre_id: maker6.id)
CarGenre.find_or_create_by!(car_id: car6.id, subgenre_id: bodytype6.id)
CarGenre.find_or_create_by!(car_id: car7.id, subgenre_id: maker1.id)
CarGenre.find_or_create_by!(car_id: car7.id, subgenre_id: bodytype1.id)
CarGenre.find_or_create_by!(car_id: car8.id, subgenre_id: maker2.id)
CarGenre.find_or_create_by!(car_id: car8.id, subgenre_id: bodytype2.id)
CarGenre.find_or_create_by!(car_id: car9.id, subgenre_id: maker3.id)
CarGenre.find_or_create_by!(car_id: car9.id, subgenre_id: bodytype3.id)
CarGenre.find_or_create_by!(car_id: car10.id, subgenre_id: maker4.id)
CarGenre.find_or_create_by!(car_id: car10.id, subgenre_id: bodytype4.id)