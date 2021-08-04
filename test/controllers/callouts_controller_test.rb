require "test_helper"

class CalloutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @callout = callouts(:one)
  end

  test "should get index" do
    get callouts_url
    assert_response :success
  end

  test "should get new" do
    get new_callout_url
    assert_response :success
  end

  test "should create callout" do
    assert_difference('Callout.count') do
      post callouts_url, params: { callout: { archive: @callout.archive, en_body: @callout.en_body, en_link_name: @callout.en_link_name, en_title: @callout.en_title, external_link: @callout.external_link, hmn_body: @callout.hmn_body, hmn_link_name: @callout.hmn_link_name, hmn_title: @callout.hmn_title, link: @callout.link, vi_body: @callout.vi_body, vi_link_name: @callout.vi_link_name, vi_title: @callout.vi_title, zh_cn_body: @callout.zh_cn_body, zh_cn_link_name: @callout.zh_cn_link_name, zh_cn_title: @callout.zh_cn_title, zh_tw_body: @callout.zh_tw_body, zh_tw_link_name: @callout.zh_tw_link_name, zh_tw_title: @callout.zh_tw_title } }
    end

    assert_redirected_to callout_url(Callout.last)
  end

  test "should show callout" do
    get callout_url(@callout)
    assert_response :success
  end

  test "should get edit" do
    get edit_callout_url(@callout)
    assert_response :success
  end

  test "should update callout" do
    patch callout_url(@callout), params: { callout: { archive: @callout.archive, en_body: @callout.en_body, en_link_name: @callout.en_link_name, en_title: @callout.en_title, external_link: @callout.external_link, hmn_body: @callout.hmn_body, hmn_link_name: @callout.hmn_link_name, hmn_title: @callout.hmn_title, link: @callout.link, vi_body: @callout.vi_body, vi_link_name: @callout.vi_link_name, vi_title: @callout.vi_title, zh_cn_body: @callout.zh_cn_body, zh_cn_link_name: @callout.zh_cn_link_name, zh_cn_title: @callout.zh_cn_title, zh_tw_body: @callout.zh_tw_body, zh_tw_link_name: @callout.zh_tw_link_name, zh_tw_title: @callout.zh_tw_title } }
    assert_redirected_to callout_url(@callout)
  end

  test "should destroy callout" do
    assert_difference('Callout.count', -1) do
      delete callout_url(@callout)
    end

    assert_redirected_to callouts_url
  end
end
