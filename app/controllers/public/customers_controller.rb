class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  before_action :check_customer, only: [:mypage, :edit, :update, :withdraw]

  def mypage
    @guest_appointment = current_customer.appointments.search(params[:appointment_id], params[:guest_email])
    
    @appointments = current_customer.appointments.page(params[:page]).per(10).order(created_at: :desc)
    @enquiries = current_customer.enquiries.page(params[:page]).per(10).order(created_at: :desc)
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to mypage_path, notice: "会員情報を更新しました"
    else
      render :edit, alert: "更新に失敗しました"
    end
  end

  def confirm_withdraw
  end

  def withdraw
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会処理が完了しました"
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :post_code, :phone_number)
  end

  def check_customer
    @customer = current_customer
  end

end
