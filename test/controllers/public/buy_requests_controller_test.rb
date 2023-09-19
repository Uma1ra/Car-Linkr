require "test_helper"

class Public::BuyRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_buy_requests_index_url
    assert_response :success
  end

  test "should get new" do
    get public_buy_requests_new_url
    assert_response :success
  end

  test "should get show" do
    get public_buy_requests_show_url
    assert_response :success
  end
end
