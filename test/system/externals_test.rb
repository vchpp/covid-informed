require "application_system_test_case"

class ExternalsTest < ApplicationSystemTestCase
  setup do
    @external = externals(:one)
  end

  test "visiting the index" do
    visit externals_url
    assert_selector "h1", text: "Externals"
  end

  test "creating a External" do
    visit externals_url
    click_on "New External"

    fill_in "En content", with: @external.en_content
    fill_in "En external link", with: @external.en_external_link
    fill_in "En notes", with: @external.en_notes
    fill_in "En source", with: @external.en_source
    fill_in "En title", with: @external.en_title
    fill_in "Hmn content", with: @external.hmn_content
    fill_in "Hmn external link", with: @external.hmn_external_link
    fill_in "Hmn notes", with: @external.hmn_notes
    fill_in "Hmn source", with: @external.hmn_source
    fill_in "Hmn title", with: @external.hmn_title
    fill_in "Languages", with: @external.languages
    fill_in "Last version date", with: @external.last_version_date
    fill_in "Vi content", with: @external.vi_content
    fill_in "Vi external link", with: @external.vi_external_link
    fill_in "Vi notes", with: @external.vi_notes
    fill_in "Vi source", with: @external.vi_source
    fill_in "Vi title", with: @external.vi_title
    fill_in "Zh cn", with: @external.zh_cn
    fill_in "Zh cn content", with: @external.zh_cn_content
    fill_in "Zh cn external link", with: @external.zh_cn_external_link
    fill_in "Zh cn notes", with: @external.zh_cn_notes
    fill_in "Zh cn title", with: @external.zh_cn_title
    fill_in "Zh tw content", with: @external.zh_tw_content
    fill_in "Zh tw external link", with: @external.zh_tw_external_link
    fill_in "Zh tw notes", with: @external.zh_tw_notes
    fill_in "Zh tw source", with: @external.zh_tw_source
    fill_in "Zh tw title", with: @external.zh_tw_title
    click_on "Create External"

    assert_text "External was successfully created"
    click_on "Back"
  end

  test "updating a External" do
    visit externals_url
    click_on "Edit", match: :first

    fill_in "En content", with: @external.en_content
    fill_in "En external link", with: @external.en_external_link
    fill_in "En notes", with: @external.en_notes
    fill_in "En source", with: @external.en_source
    fill_in "En title", with: @external.en_title
    fill_in "Hmn content", with: @external.hmn_content
    fill_in "Hmn external link", with: @external.hmn_external_link
    fill_in "Hmn notes", with: @external.hmn_notes
    fill_in "Hmn source", with: @external.hmn_source
    fill_in "Hmn title", with: @external.hmn_title
    fill_in "Languages", with: @external.languages
    fill_in "Last version date", with: @external.last_version_date
    fill_in "Vi content", with: @external.vi_content
    fill_in "Vi external link", with: @external.vi_external_link
    fill_in "Vi notes", with: @external.vi_notes
    fill_in "Vi source", with: @external.vi_source
    fill_in "Vi title", with: @external.vi_title
    fill_in "Zh cn", with: @external.zh_cn
    fill_in "Zh cn content", with: @external.zh_cn_content
    fill_in "Zh cn external link", with: @external.zh_cn_external_link
    fill_in "Zh cn notes", with: @external.zh_cn_notes
    fill_in "Zh cn title", with: @external.zh_cn_title
    fill_in "Zh tw content", with: @external.zh_tw_content
    fill_in "Zh tw external link", with: @external.zh_tw_external_link
    fill_in "Zh tw notes", with: @external.zh_tw_notes
    fill_in "Zh tw source", with: @external.zh_tw_source
    fill_in "Zh tw title", with: @external.zh_tw_title
    click_on "Update External"

    assert_text "External was successfully updated"
    click_on "Back"
  end

  test "destroying a External" do
    visit externals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "External was successfully destroyed"
  end
end
