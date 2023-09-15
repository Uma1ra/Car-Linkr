class Admin::CarsController < ApplicationController
  before_action :find_car_id, only: [:show, :edit, :update, :destroy]

  def index
    @cars = Car.page(params[:page]).per(10)
  end

  def new
    @car = Car.new
    @car_genre = CarGenre.new
    @genres = Genre.all
  end

  def create
    @car = Car.new(car_params)
    if @car.save!
      redirect_to admin_car_path(@car.id), notice: "出品登録されました"
    else
      render :new, alert: "出品登録に失敗しました"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @car.update
      redirect_to admin_car_path(@car), notice: "編集に成功しました"
    else
      render :edit, alert: "編集に失敗しました"
    end
  end

  def destroy
    if @car.destroy
      redirect_to admin_cars_path, notice: "出品を削除しました"
    else
      render :show, alert: "削除に失敗しました"
    end
  end

  private

  def car_params
    params.require(:car).permit(:name, :detail, :price, :color, :passenger_amount, :year, :chassis_code, :mileage, :is_km, :shaken_period, :shaken_finish, :grade, :engine_capacity, :transmission, :fuel, :is_available, images: [])
  end

  def find_car_id
    @car = Car.find(params[:id])
  end

end
