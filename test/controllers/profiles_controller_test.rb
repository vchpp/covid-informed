require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_profile_url
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post profiles_url, params: { profile: { en_affiliation: @profile.en_affiliation, en_bio: @profile.en_bio, en_project_title: @profile.en_project_title, external_links: @profile.external_links, firstname: @profile.firstname, hmn_affiliation: @profile.hmn_affiliation, hmn_bio: @profile.hmn_bio, hmn_project_title: @profile.hmn_project_title, lastname: @profile.lastname, middlename: @profile.middlename, middlename2: @profile.middlename2, type: @profile.type, vi_affiliation: @profile.vi_affiliation, vi_bio: @profile.vi_bio, vi_project_title: @profile.vi_project_title, zh_cn_affiliation: @profile.zh_cn_affiliation, zh_cn_bio: @profile.zh_cn_bio, zh_cn_project_title: @profile.zh_cn_project_title, zh_tw_affiliation: @profile.zh_tw_affiliation, zh_tw_bio: @profile.zh_tw_bio, zh_tw_project_title: @profile.zh_tw_project_title } }
    end

    assert_redirected_to profile_url(Profile.last)
  end

  test "should show profile" do
    get profile_url(@profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
    patch profile_url(@profile), params: { profile: { en_affiliation: @profile.en_affiliation, en_bio: @profile.en_bio, en_project_title: @profile.en_project_title, external_links: @profile.external_links, firstname: @profile.firstname, hmn_affiliation: @profile.hmn_affiliation, hmn_bio: @profile.hmn_bio, hmn_project_title: @profile.hmn_project_title, lastname: @profile.lastname, middlename: @profile.middlename, middlename2: @profile.middlename2, type: @profile.type, vi_affiliation: @profile.vi_affiliation, vi_bio: @profile.vi_bio, vi_project_title: @profile.vi_project_title, zh_cn_affiliation: @profile.zh_cn_affiliation, zh_cn_bio: @profile.zh_cn_bio, zh_cn_project_title: @profile.zh_cn_project_title, zh_tw_affiliation: @profile.zh_tw_affiliation, zh_tw_bio: @profile.zh_tw_bio, zh_tw_project_title: @profile.zh_tw_project_title } }
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete profile_url(@profile)
    end

    assert_redirected_to profiles_url
  end
end
