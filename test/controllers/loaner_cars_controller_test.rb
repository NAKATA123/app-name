require "test_helper"

class LoanerCarsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get loaner_cars_index_url
    assert_response :success
  end
end
