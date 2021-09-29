require "application_system_test_case"

class StatisticsTest < ApplicationSystemTestCase
  setup do
    @statistic = statistics(:one)
  end

  test "visiting the index" do
    visit statistics_url
    assert_selector "h1", text: "Statistics"
  end

  test "creating a Statistic" do
    visit statistics_url
    click_on "New Statistic"

    fill_in "Category", with: @statistic.category
    fill_in "En description", with: @statistic.en_description
    fill_in "En link name", with: @statistic.en_link_name
    fill_in "En title", with: @statistic.en_title
    fill_in "Hmn description", with: @statistic.hmn_description
    fill_in "Hmn link name", with: @statistic.hmn_link_name
    fill_in "Hmn title", with: @statistic.hmn_title
    fill_in "Link url", with: @statistic.link_url
    fill_in "Vi description", with: @statistic.vi_description
    fill_in "Vi link name", with: @statistic.vi_link_name
    fill_in "Vi title", with: @statistic.vi_title
    fill_in "Zh cn description", with: @statistic.zh_cn_description
    fill_in "Zh cn link name", with: @statistic.zh_cn_link_name
    fill_in "Zh cn title", with: @statistic.zh_cn_title
    fill_in "Zh tw description", with: @statistic.zh_tw_description
    fill_in "Zh tw link name", with: @statistic.zh_tw_link_name
    fill_in "Zh tw title", with: @statistic.zh_tw_title
    click_on "Create Statistic"

    assert_text "Statistic was successfully created"
    click_on "Back"
  end

  test "updating a Statistic" do
    visit statistics_url
    click_on "Edit", match: :first

    fill_in "Category", with: @statistic.category
    fill_in "En description", with: @statistic.en_description
    fill_in "En link name", with: @statistic.en_link_name
    fill_in "En title", with: @statistic.en_title
    fill_in "Hmn description", with: @statistic.hmn_description
    fill_in "Hmn link name", with: @statistic.hmn_link_name
    fill_in "Hmn title", with: @statistic.hmn_title
    fill_in "Link url", with: @statistic.link_url
    fill_in "Vi description", with: @statistic.vi_description
    fill_in "Vi link name", with: @statistic.vi_link_name
    fill_in "Vi title", with: @statistic.vi_title
    fill_in "Zh cn description", with: @statistic.zh_cn_description
    fill_in "Zh cn link name", with: @statistic.zh_cn_link_name
    fill_in "Zh cn title", with: @statistic.zh_cn_title
    fill_in "Zh tw description", with: @statistic.zh_tw_description
    fill_in "Zh tw link name", with: @statistic.zh_tw_link_name
    fill_in "Zh tw title", with: @statistic.zh_tw_title
    click_on "Update Statistic"

    assert_text "Statistic was successfully updated"
    click_on "Back"
  end

  test "destroying a Statistic" do
    visit statistics_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Statistic was successfully destroyed"
  end
end
