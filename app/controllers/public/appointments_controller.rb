class Public::AppointmentsController < ApplicationController

  def index
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @buy_request = BuyRequest.new(buy_request_params)
    @sell_request = SellRequest.new(sell_request_params)
    @sell_detail = SellDetail.new(sell_detail_params)

    if @appointment.save
      @buy_request.appointment_id = @appointment.id
      @buy_request.save
      
      @sell_request.appointment_id = @appointment.id
      @sell_request.save
      
      @sell_detail.sell_request_id = @sell_request.id
      @sell_detail.save
      
      redirect_to appointment_path(@appointment), notice: "予約の申し込みが完了しました"
    else
      render :buy_and_sell, alert: "予約の申し込みに失敗しました"
    end
  end

  def buy_and_sell
    @appointment = Appointment.new
    @buy_request = BuyRequest.new
    @sell_request = SellRequest.new
    @sell_detail = SellDetail.new
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  private

  def appointment_params
    params.require(:appointment).permit(:customer_id, :name, :phone_number, :post_code, :email, :category)
  end
  
  def buy_request_params
    params.require(:buy_request).permit(:car_id, :appointment_id, :comment, :option_a, :option_b, :option_c)
  end
  
  def sell_request_params
    params.require(:sell_request).permit(:appointment_id, :comment, :option_a, :option_b, :option_c)
  end
  
  def sell_detail_params
    params.require(:sell_detail).permit(:sell_request_id, :car_name, :chassis_no, :year, :chassis_code, :mileage,:is_km, :shaken_period, :shaken_finish, sell_images: [])
  end

end
