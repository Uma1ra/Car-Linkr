class Admin::EnquiriesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @enquiries = Enquiry.page(params[:page]).per(10)
  end
  
end
