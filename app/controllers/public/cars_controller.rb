class Public::CarsController < ApplicationController

  def index
    @customer = Customer.new
    if params[:word]
      @cars = Car.search(params[:word])
    else
      @cars = Car.all
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
