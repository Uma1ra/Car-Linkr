require "test_helper"

class Public::CarsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_cars_index_url
    assert_response :success
  end

  test "should get show" do
    get public_cars_show_url
    assert_response :success
  end
end
