require "test_helper"

class RepairsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get repairs_show_url
    assert_response :success
  end
end
