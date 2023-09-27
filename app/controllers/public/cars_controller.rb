class Public::CarsController < ApplicationController

  def index
    @customer = Customer.new
    @available_cars = Car.where(is_available: true)
    
    if params[:word]
      @cars = @available_cars.search(params[:word]).page(params[:page]).per(6.order(created_at: :desc))
    else
      @cars = @available_cars.page(params[:page]).per(6).order(created_at: :desc)
    end
  end

  def show
    @car = Car.find(params[:id])
    buy_request = BuyRequest.new
    buy_request.car_id = @car.id
  end

  def search
    @cars = Car.search(params[:word])
  end

  def car_params
    params.require(:car).permit(:name, :detail, :price, :color, :passenger_amount, :year, :chassis_code, :mileage, :is_km, :shaken_period, :shaken_finish, :grade, :engine_capacity, :transmission, :fuel, :is_available, images: [], subgenre_ids: [])
  end

end
