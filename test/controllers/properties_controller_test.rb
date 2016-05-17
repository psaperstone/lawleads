require 'test_helper'

class PropertiesControllerTest < ActionController::TestCase
  setup do
    @property = properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property" do
    assert_difference('Property.count') do
      post :create, property: { assessed_value: @property.assessed_value, legal_desc: @property.legal_desc, mail_city: @property.mail_city, mail_str_addr: @property.mail_str_addr, mail_zip: @property.mail_zip, owner: @property.owner, prop_acct_num: @property.prop_acct_num, prop_city: @property.prop_city, prop_str_addr: @property.prop_str_addr, prop_zip: @property.prop_zip }
    end

    assert_redirected_to property_path(assigns(:property))
  end

  test "should show property" do
    get :show, id: @property
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property
    assert_response :success
  end

  test "should update property" do
    patch :update, id: @property, property: { assessed_value: @property.assessed_value, legal_desc: @property.legal_desc, mail_city: @property.mail_city, mail_str_addr: @property.mail_str_addr, mail_zip: @property.mail_zip, owner: @property.owner, prop_acct_num: @property.prop_acct_num, prop_city: @property.prop_city, prop_str_addr: @property.prop_str_addr, prop_zip: @property.prop_zip }
    assert_redirected_to property_path(assigns(:property))
  end

  test "should destroy property" do
    assert_difference('Property.count', -1) do
      delete :destroy, id: @property
    end

    assert_redirected_to properties_path
  end
end
