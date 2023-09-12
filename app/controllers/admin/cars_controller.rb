class Admin::CarsController < ApplicationController

  def index
    @cars = Car.page(params[:page]).per(10)
  end
  
  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to admin_car_path(@car.id), notice: "出品登録されました"
    else
      render :new, alert: "出品登録に失敗しました"
    end
  end

  def show
    @car = Car.find(params[:id])
  end

  private

  def car_params
    params.require(:car).permit(:name, :detail, :price, :color, :passenger_amount, :year, :chassis_code, :mileage, :is_km, :shaken_period, :shaken_finish, :grade, :engine_capacity, :transmission, :fuel, :is_available, images: [])
  end

end
