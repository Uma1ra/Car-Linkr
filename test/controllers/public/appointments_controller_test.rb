require "test_helper"

class Public::AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_appointments_index_url
    assert_response :success
  end

  test "should get show" do
    get public_appointments_show_url
    assert_response :success
  end
end
