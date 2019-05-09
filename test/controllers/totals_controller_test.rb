require 'test_helper'

class TotalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @total = totals(:one)
  end

  test "should get index" do
    get totals_url, as: :json
    assert_response :success
  end

  test "should create total" do
    assert_difference('Total.count') do
      post totals_url, params: { total: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show total" do
    get total_url(@total), as: :json
    assert_response :success
  end

  test "should update total" do
    patch total_url(@total), params: { total: {  } }, as: :json
    assert_response 200
  end

  test "should destroy total" do
    assert_difference('Total.count', -1) do
      delete total_url(@total), as: :json
    end

    assert_response 204
  end
end
