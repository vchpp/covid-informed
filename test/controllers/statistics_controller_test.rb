require "test_helper"

class StatisticsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @statistic = statistics(:one)
  end

  test "should get index" do
    get statistics_url
    assert_response :success
  end

  test "should get new" do
    get new_statistic_url
    assert_response :success
  end

  test "should create statistic" do
    assert_difference('Statistic.count') do
      post statistics_url, params: { statistic: { category: @statistic.category, en_description: @statistic.en_description, en_link_name: @statistic.en_link_name, en_title: @statistic.en_title, hmn_description: @statistic.hmn_description, hmn_link_name: @statistic.hmn_link_name, hmn_title: @statistic.hmn_title, link_url: @statistic.link_url, vi_description: @statistic.vi_description, vi_link_name: @statistic.vi_link_name, vi_title: @statistic.vi_title, zh_cn_description: @statistic.zh_cn_description, zh_cn_link_name: @statistic.zh_cn_link_name, zh_cn_title: @statistic.zh_cn_title, zh_tw_description: @statistic.zh_tw_description, zh_tw_link_name: @statistic.zh_tw_link_name, zh_tw_title: @statistic.zh_tw_title } }
    end

    assert_redirected_to statistic_url(Statistic.last)
  end

  test "should show statistic" do
    get statistic_url(@statistic)
    assert_response :success
  end

  test "should get edit" do
    get edit_statistic_url(@statistic)
    assert_response :success
  end

  test "should update statistic" do
    patch statistic_url(@statistic), params: { statistic: { category: @statistic.category, en_description: @statistic.en_description, en_link_name: @statistic.en_link_name, en_title: @statistic.en_title, hmn_description: @statistic.hmn_description, hmn_link_name: @statistic.hmn_link_name, hmn_title: @statistic.hmn_title, link_url: @statistic.link_url, vi_description: @statistic.vi_description, vi_link_name: @statistic.vi_link_name, vi_title: @statistic.vi_title, zh_cn_description: @statistic.zh_cn_description, zh_cn_link_name: @statistic.zh_cn_link_name, zh_cn_title: @statistic.zh_cn_title, zh_tw_description: @statistic.zh_tw_description, zh_tw_link_name: @statistic.zh_tw_link_name, zh_tw_title: @statistic.zh_tw_title } }
    assert_redirected_to statistic_url(@statistic)
  end

  test "should destroy statistic" do
    assert_difference('Statistic.count', -1) do
      delete statistic_url(@statistic)
    end

    assert_redirected_to statistics_url
  end
end
