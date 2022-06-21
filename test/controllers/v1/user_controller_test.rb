require 'test_helper'

class V1::UserControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get v1_user_index_url
    assert_response :success
  end

  test 'should get create' do
    get v1_user_create_url
    assert_response :success
  end

  test 'should get update' do
    get v1_user_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get v1_user_destroy_url
    assert_response :success
  end
end
