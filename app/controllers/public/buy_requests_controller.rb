class Public::BuyRequestsController < ApplicationController
before_action :authenticate_customer!

  def new
    @buy_request = BuyRequest.new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @buy_request = BuyRequest.new(buy_request_params)
    
    if @appointment.save
      @buy_request.appointment_id = @appointment.id
      @buy_request.save
      
      redirect_to appointment_path(@appointment), notice: "予約の申し込みが完了しました"
    else
      render :new, alert: "予約の申し込みに失敗しました"
    end
  end

  private

  def buy_request_params
    params.require(:buy_request).permit(:car_id, :appointment_id, :comment, :option_a, :option_b, :option_c)
  end

  def appointment_params
    params.require(:appointment).permit(:customer_id, :name, :phone_number, :post_code, :email, :category)
  end

end