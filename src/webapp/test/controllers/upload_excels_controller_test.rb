require 'test_helper'

class UploadExcelsControllerTest < ActionDispatch::IntegrationTest
  test "should get orders" do
    get upload_excels_orders_url
    assert_response :success
  end

  test "should get workers" do
    get upload_excels_workers_url
    assert_response :success
  end

  test "should get worked_hours" do
    get upload_excels_worked_hours_url
    assert_response :success
  end

end
