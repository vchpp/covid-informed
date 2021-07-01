require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  setup do
    @profile = profiles(:one)
  end

  test "visiting the index" do
    visit profiles_url
    assert_selector "h1", text: "Profiles"
  end

  test "creating a Profile" do
    visit profiles_url
    click_on "New Profile"

    fill_in "En affiliation", with: @profile.en_affiliation
    fill_in "En bio", with: @profile.en_bio
    fill_in "En project title", with: @profile.en_project_title
    fill_in "External links", with: @profile.external_links
    fill_in "Firstname", with: @profile.firstname
    fill_in "Hmn affiliation", with: @profile.hmn_affiliation
    fill_in "Hmn bio", with: @profile.hmn_bio
    fill_in "Hmn project title", with: @profile.hmn_project_title
    fill_in "Lastname", with: @profile.lastname
    fill_in "Middlename", with: @profile.middlename
    fill_in "Middlename2", with: @profile.middlename2
    fill_in "Type", with: @profile.type
    fill_in "Vi affiliation", with: @profile.vi_affiliation
    fill_in "Vi bio", with: @profile.vi_bio
    fill_in "Vi project title", with: @profile.vi_project_title
    fill_in "Zh cn affiliation", with: @profile.zh_cn_affiliation
    fill_in "Zh cn bio", with: @profile.zh_cn_bio
    fill_in "Zh cn project title", with: @profile.zh_cn_project_title
    fill_in "Zh tw affiliation", with: @profile.zh_tw_affiliation
    fill_in "Zh tw bio", with: @profile.zh_tw_bio
    fill_in "Zh tw project title", with: @profile.zh_tw_project_title
    click_on "Create Profile"

    assert_text "Profile was successfully created"
    click_on "Back"
  end

  test "updating a Profile" do
    visit profiles_url
    click_on "Edit", match: :first

    fill_in "En affiliation", with: @profile.en_affiliation
    fill_in "En bio", with: @profile.en_bio
    fill_in "En project title", with: @profile.en_project_title
    fill_in "External links", with: @profile.external_links
    fill_in "Firstname", with: @profile.firstname
    fill_in "Hmn affiliation", with: @profile.hmn_affiliation
    fill_in "Hmn bio", with: @profile.hmn_bio
    fill_in "Hmn project title", with: @profile.hmn_project_title
    fill_in "Lastname", with: @profile.lastname
    fill_in "Middlename", with: @profile.middlename
    fill_in "Middlename2", with: @profile.middlename2
    fill_in "Type", with: @profile.type
    fill_in "Vi affiliation", with: @profile.vi_affiliation
    fill_in "Vi bio", with: @profile.vi_bio
    fill_in "Vi project title", with: @profile.vi_project_title
    fill_in "Zh cn affiliation", with: @profile.zh_cn_affiliation
    fill_in "Zh cn bio", with: @profile.zh_cn_bio
    fill_in "Zh cn project title", with: @profile.zh_cn_project_title
    fill_in "Zh tw affiliation", with: @profile.zh_tw_affiliation
    fill_in "Zh tw bio", with: @profile.zh_tw_bio
    fill_in "Zh tw project title", with: @profile.zh_tw_project_title
    click_on "Update Profile"

    assert_text "Profile was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile" do
    visit profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile was successfully destroyed"
  end
end
