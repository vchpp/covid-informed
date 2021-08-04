require "application_system_test_case"

class CalloutsTest < ApplicationSystemTestCase
  setup do
    @callout = callouts(:one)
  end

  test "visiting the index" do
    visit callouts_url
    assert_selector "h1", text: "Callouts"
  end

  test "creating a Callout" do
    visit callouts_url
    click_on "New Callout"

    check "Archive" if @callout.archive
    fill_in "En body", with: @callout.en_body
    fill_in "En link name", with: @callout.en_link_name
    fill_in "En title", with: @callout.en_title
    check "External link" if @callout.external_link
    fill_in "Hmn body", with: @callout.hmn_body
    fill_in "Hmn link name", with: @callout.hmn_link_name
    fill_in "Hmn title", with: @callout.hmn_title
    fill_in "Link", with: @callout.link
    fill_in "Vi body", with: @callout.vi_body
    fill_in "Vi link name", with: @callout.vi_link_name
    fill_in "Vi title", with: @callout.vi_title
    fill_in "Zh cn body", with: @callout.zh_cn_body
    fill_in "Zh cn link name", with: @callout.zh_cn_link_name
    fill_in "Zh cn title", with: @callout.zh_cn_title
    fill_in "Zh tw body", with: @callout.zh_tw_body
    fill_in "Zh tw link name", with: @callout.zh_tw_link_name
    fill_in "Zh tw title", with: @callout.zh_tw_title
    click_on "Create Callout"

    assert_text "Callout was successfully created"
    click_on "Back"
  end

  test "updating a Callout" do
    visit callouts_url
    click_on "Edit", match: :first

    check "Archive" if @callout.archive
    fill_in "En body", with: @callout.en_body
    fill_in "En link name", with: @callout.en_link_name
    fill_in "En title", with: @callout.en_title
    check "External link" if @callout.external_link
    fill_in "Hmn body", with: @callout.hmn_body
    fill_in "Hmn link name", with: @callout.hmn_link_name
    fill_in "Hmn title", with: @callout.hmn_title
    fill_in "Link", with: @callout.link
    fill_in "Vi body", with: @callout.vi_body
    fill_in "Vi link name", with: @callout.vi_link_name
    fill_in "Vi title", with: @callout.vi_title
    fill_in "Zh cn body", with: @callout.zh_cn_body
    fill_in "Zh cn link name", with: @callout.zh_cn_link_name
    fill_in "Zh cn title", with: @callout.zh_cn_title
    fill_in "Zh tw body", with: @callout.zh_tw_body
    fill_in "Zh tw link name", with: @callout.zh_tw_link_name
    fill_in "Zh tw title", with: @callout.zh_tw_title
    click_on "Update Callout"

    assert_text "Callout was successfully updated"
    click_on "Back"
  end

  test "destroying a Callout" do
    visit callouts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Callout was successfully destroyed"
  end
end
