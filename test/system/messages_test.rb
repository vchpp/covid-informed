require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  setup do
    @message = messages(:one)
  end

  test "visiting the index" do
    visit messages_url
    assert_selector "h1", text: "Messages"
  end

  test "creating a Message" do
    visit messages_url
    click_on "New Message"

    fill_in "En content", with: @message.en_content
    fill_in "En name", with: @message.en_name
    fill_in "Hmn content", with: @message.hmn_content
    fill_in "Hmn name", with: @message.hmn_name
    fill_in "Vi content", with: @message.vi_content
    fill_in "Vi name", with: @message.vi_name
    fill_in "Zh cn content", with: @message.zh_cn_content
    fill_in "Zh cn name", with: @message.zh_cn_name
    fill_in "Zh tw content", with: @message.zh_tw_content
    fill_in "Zh tw name", with: @message.zh_tw_name
    click_on "Create Message"

    assert_text "Message was successfully created"
    click_on "Back"
  end

  test "updating a Message" do
    visit messages_url
    click_on "Edit", match: :first

    fill_in "En content", with: @message.en_content
    fill_in "En name", with: @message.en_name
    fill_in "Hmn content", with: @message.hmn_content
    fill_in "Hmn name", with: @message.hmn_name
    fill_in "Vi content", with: @message.vi_content
    fill_in "Vi name", with: @message.vi_name
    fill_in "Zh cn content", with: @message.zh_cn_content
    fill_in "Zh cn name", with: @message.zh_cn_name
    fill_in "Zh tw content", with: @message.zh_tw_content
    fill_in "Zh tw name", with: @message.zh_tw_name
    click_on "Update Message"

    assert_text "Message was successfully updated"
    click_on "Back"
  end

  test "destroying a Message" do
    visit messages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Message was successfully destroyed"
  end
end
