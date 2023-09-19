require "test_helper"

class Public::SellRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_sell_requests_index_url
    assert_response :success
  end

  test "should get new" do
    get public_sell_requests_new_url
    assert_response :success
  end

  test "should get show" do
    get public_sell_requests_show_url
    assert_response :success
  end
end
