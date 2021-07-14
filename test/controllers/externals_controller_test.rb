require "test_helper"

class ExternalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @external = externals(:one)
  end

  test "should get index" do
    get externals_url
    assert_response :success
  end

  test "should get new" do
    get new_external_url
    assert_response :success
  end

  test "should create external" do
    assert_difference('External.count') do
      post externals_url, params: { external: { en_content: @external.en_content, en_external_link: @external.en_external_link, en_notes: @external.en_notes, en_source: @external.en_source, en_title: @external.en_title, hmn_content: @external.hmn_content, hmn_external_link: @external.hmn_external_link, hmn_notes: @external.hmn_notes, hmn_source: @external.hmn_source, hmn_title: @external.hmn_title, languages: @external.languages, last_version_date: @external.last_version_date, vi_content: @external.vi_content, vi_external_link: @external.vi_external_link, vi_notes: @external.vi_notes, vi_source: @external.vi_source, vi_title: @external.vi_title, zh_cn: @external.zh_cn, zh_cn_content: @external.zh_cn_content, zh_cn_external_link: @external.zh_cn_external_link, zh_cn_notes: @external.zh_cn_notes, zh_cn_title: @external.zh_cn_title, zh_tw_content: @external.zh_tw_content, zh_tw_external_link: @external.zh_tw_external_link, zh_tw_notes: @external.zh_tw_notes, zh_tw_source: @external.zh_tw_source, zh_tw_title: @external.zh_tw_title } }
    end

    assert_redirected_to external_url(External.last)
  end

  test "should show external" do
    get external_url(@external)
    assert_response :success
  end

  test "should get edit" do
    get edit_external_url(@external)
    assert_response :success
  end

  test "should update external" do
    patch external_url(@external), params: { external: { en_content: @external.en_content, en_external_link: @external.en_external_link, en_notes: @external.en_notes, en_source: @external.en_source, en_title: @external.en_title, hmn_content: @external.hmn_content, hmn_external_link: @external.hmn_external_link, hmn_notes: @external.hmn_notes, hmn_source: @external.hmn_source, hmn_title: @external.hmn_title, languages: @external.languages, last_version_date: @external.last_version_date, vi_content: @external.vi_content, vi_external_link: @external.vi_external_link, vi_notes: @external.vi_notes, vi_source: @external.vi_source, vi_title: @external.vi_title, zh_cn: @external.zh_cn, zh_cn_content: @external.zh_cn_content, zh_cn_external_link: @external.zh_cn_external_link, zh_cn_notes: @external.zh_cn_notes, zh_cn_title: @external.zh_cn_title, zh_tw_content: @external.zh_tw_content, zh_tw_external_link: @external.zh_tw_external_link, zh_tw_notes: @external.zh_tw_notes, zh_tw_source: @external.zh_tw_source, zh_tw_title: @external.zh_tw_title } }
    assert_redirected_to external_url(@external)
  end

  test "should destroy external" do
    assert_difference('External.count', -1) do
      delete external_url(@external)
    end

    assert_redirected_to externals_url
  end
end
