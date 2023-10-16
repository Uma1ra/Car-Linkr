class Public::SellRequestMailer < ApplicationMailer

  def new_sell_request_email
    @sell_request = params[:sell_request]
    @sell_detail = @sell_request.sell_detail
    @appointment = @sell_request.appointment

    mail(
      to: ENV["EMAIL"],
      subject: "【買取見積り】予約申し込み完了",
      bcc: @sell_request.appointment.email
    )
  end

end
