class Public::EnquiriesController < ApplicationController
  before_action :authenticate_customer!

  def new
    @enquiry = Enquiry.new
  end

  def create
    @enquiry = Enquiry.new(enquiry_params)
    if @enquiry.save
      Public::EnquiryMailer.new_enquiry_email(@enquiry).deliver

      redirect_to enquiry_path(enquiry_id: @enquiry.id), notice: "お問い合わせを送信しました"
    else
      flash[:alert] = "送信に失敗しました"
      render :new
    end
  end

  def show
    @enquiry = Enquiry.find(params[:enquiry_id])
  end

  private

  def enquiry_params
    params.require(:enquiry).permit(:customer_id, :phone_number, :email, :title, :detail)
  end

end
