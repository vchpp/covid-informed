require "application_system_test_case"

class DownloadsTest < ApplicationSystemTestCase
  setup do
    @download = downloads(:one)
  end

  test "visiting the index" do
    visit downloads_url
    assert_selector "h1", text: "Downloads"
  end

  test "creating a Download" do
    visit downloads_url
    click_on "New Download"

    check "Archive" if @download.archive
    fill_in "En file", with: @download.en_file
    fill_in "Hmn file", with: @download.hmn_file
    fill_in "Vi file", with: @download.vi_file
    fill_in "Zh cn file", with: @download.zh_cn_file
    fill_in "Zh tw file", with: @download.zh_tw_file
    click_on "Create Download"

    assert_text "Download was successfully created"
    click_on "Back"
  end

  test "updating a Download" do
    visit downloads_url
    click_on "Edit", match: :first

    check "Archive" if @download.archive
    fill_in "En file", with: @download.en_file
    fill_in "Hmn file", with: @download.hmn_file
    fill_in "Vi file", with: @download.vi_file
    fill_in "Zh cn file", with: @download.zh_cn_file
    fill_in "Zh tw file", with: @download.zh_tw_file
    click_on "Update Download"

    assert_text "Download was successfully updated"
    click_on "Back"
  end

  test "destroying a Download" do
    visit downloads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Download was successfully destroyed"
  end
end
