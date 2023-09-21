class Admin::CarsController < ApplicationController
  before_action :find_car_id, only: [:show, :edit, :update, :destroy]

  def index
    if params[:subgenre_id]
      subgenre = Subgenre.find(params[:subgenre_id])
      @cars = subgenre.cars.page(params[:page]).per(10)
    else
      @cars = Car.page(params[:page]).per(10)
    end
  end

  def new
    @car = Car.new
  # サブジャンルの方から必要なジャンルのみ
    @genres = Genre.where(id:Subgenre.all.pluck(:genre_id))
  end

  def create
    @car = Car.new(car_params)

    if @car.save
  # car_paramsで送られてきたkeyの中から、サブジャンルのidが入ったパラメータを文字列で検索して取得
    subgenre_ids = params[:car].keys.select {|key| key.include?("subgenre")}
    subgenre_ids.each do |subgenre_id|
  # 取得したkeyにサブジャンルが存在する場合、CarGenre内にレコードを(eachで全て)作成
      if params[:car][subgenre_id].present?
        CarGenre.create(subgenre_id: params[:car][subgenre_id],car_id: @car.id)
      end
    end
      redirect_to admin_car_path(@car.id), notice: "出品#{@car.id}登録されました"
    else
      render :new, alert: "出品#{@car.id}登録に失敗しました"
    end
  end

  def show
  end

  def edit
    #genres_ids = @car.subgenres.map{ |x| x.genre.id }
    @genres = Genre.where(id: Subgenre.all.pluck(:genre_id))
    #@subgenres = @car.subgenres
  end

  def update
    if @car.update(car_params)
      subgenre_ids = params[:car].keys.select {|key| key.include?("subgenre")}
      subgenre_ids.each do |subgenre_id|
        # 取得したkeyにサブジャンルが存在する場合、CarGenre内にレコードを(eachで全て)作成

        if params[:car][subgenre_id].present?
          binding.pry
          car_genre = CarGenre.find([subgenre_ids: :subgenre_id])
          car_genre.destroy
          CarGenre.create(subgenre_id: params[:car][subgenre_id], car_id: @car.id)
        end
      end
      redirect_to admin_car_path(@car), notice: "更新しました"
    else
      render :edit, alert: "更新に失敗しました"
    end
  end

  def destroy
    if @car.destroy
      redirect_to admin_cars_path, notice: "出品#{@car.id}を削除しました"
    else
      render :show, alert: "削除に失敗しました"
    end
  end

  private

  def car_params
    params.require(:car).permit(:name, :detail, :price, :color, :passenger_amount, :year, :chassis_code, :mileage, :is_km, :shaken_period, :shaken_finish, :grade, :engine_capacity, :transmission, :fuel, :is_available, images: [], subgenre_ids: [])
  end

  def car_genre
    params.require(:car_genre).permit(:subgenre_id, :car_id)
  end

  def find_car_id
    @car = Car.find(params[:id])
  end

end
