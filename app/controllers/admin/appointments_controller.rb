class Admin::AppointmentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @appointments = Appointment.page(params[:page]).per(10)
  end
  
end
