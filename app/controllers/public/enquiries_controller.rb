class Public::EnquiriesController < ApplicationController

  def new
    @enquiry = Enquiry.new
  end
  
  def create
    @enquiry = Enquiry.new(enquiry_params)
    if @enquiry.save
      redirect_to enquiry_path(@enquiry), notice: "お問い合わせを送信しました"
    else
      render :new, alert: "送信に失敗しました"
    end
  end
  
  def show
    @enquiry = Enquiry.find(params[:id])
  end
  
  private
  
  def enquiry_params
    params.require(:enquiry).permit(:customer_id, :title, :detail)
  end

end
