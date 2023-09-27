class Public::BuyRequestsController < ApplicationController
before_action :authenticate_customer!

  def new
    @car_id = params[:car_id]
    @buy_request = BuyRequest.new
    @appointment = Appointment.new
  end

  def create
    @car_id = params[:buy_request][:car_id]
    @appointment = Appointment.new(appointment_params)
    @buy_request = BuyRequest.new(buy_request_params)

    begin
      ActiveRecord::Base.transaction do
        save_buy_request
      end

      redirect_to appointment_path(@appointment), notice: "予約の申し込みが完了しました"
    rescue => e
      Rails.logger.error "Failed to create buy_request: #{e.message}"
      flash[:alert] = "予約の申し込みに失敗しました"
      render :new
    end
  end

  private

  def buy_request_params
    params.require(:buy_request).permit(:car_id, :appointment_id, :comment, :option_a, :option_b, :option_c)
  end

  def appointment_params
    params.require(:appointment).permit(:customer_id, :name, :phone_number, :post_code, :email, :category)
  end

  def save_buy_request
    @appointment.save!
    @buy_request.appointment_id = @appointment.id
    @buy_request.save!
  end

end
