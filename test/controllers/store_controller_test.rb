require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  fixtures :products
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'h1', "Your Pragmatic Catalog"
    assert_select 'ul.menu li a', 4
  end

end
