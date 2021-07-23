require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get users_show_url
    assert_response :success
  end

  test 'should get edit' do
    get users_edit_url
    assert_response :success
  end

  test 'should get alert' do
    get users_alert_url
    assert_response :success
  end

  test 'should get withdraw' do
    get users_withdraw_url
    assert_response :success
  end
end
