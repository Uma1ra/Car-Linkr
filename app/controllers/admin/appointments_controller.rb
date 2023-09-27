class Admin::AppointmentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @appointments = Appointment.page(params[:page]).per(10)
  end

  def show
    @appointment = Appointment.find(params[:id])
    @buy_request = @appointment.buy_request

    unless @appointment.category == "buy"
      @sell_request = @appointment.sell_request
      @sell_detail = @sell_request.sell_detail
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to admin_appointment_path(@appointment), notice: "予約状況を更新しました"
    else
      flash[:alert] = "予約状況の更新に失敗しました"
      render :edit
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:customer_id, :name, :phone_number, :post_code, :email, :category, :is_done)
  end

end
