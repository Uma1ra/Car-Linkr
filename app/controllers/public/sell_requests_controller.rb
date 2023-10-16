class Public::SellRequestsController < ApplicationController

  def new
    @sell_request = SellRequest.new
    @sell_detail = SellDetail.new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @sell_request = SellRequest.new(sell_request_params)
    @sell_detail = SellDetail.new(sell_detail_params)

    begin
      ActiveRecord::Base.transaction do
        save_sell_request
      end

      redirect_to appointment_path(@appointment), notice: "予約の申し込みが完了しました"
    rescue => e
      Rails.logger.error "Failed to create buy_request: #{e.message}"
      flash[:alert] = "予約の申し込みに失敗しました"
      render :new
    end
  end

  private

  def sell_request_params
    params.require(:sell_request).permit(:appointment_id, :comment, :option_a, :option_b, :option_c)
  end

  def sell_detail_params
    params.require(:sell_detail).permit(:sell_request_id, :car_name, :chassis_no, :year, :chassis_code, :mileage,:is_km, :shaken_period, :shaken_finish, sell_images: [])
  end

  def appointment_params
    params.require(:appointment).permit(:customer_id, :name, :phone_number, :post_code, :email, :category)
  end

  def save_sell_request
    @appointment.save!
    @sell_request.appointment_id = @appointment.id
    @sell_request.save!

    @sell_detail.sell_request_id = @sell_request.id
    @sell_detail.save!

    Public::SellRequestMailer.with(sell_request: @sell_request).new_sell_request_email.deliver!
  end

end
