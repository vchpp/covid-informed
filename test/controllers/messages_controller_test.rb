require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    get messages_url
    assert_response :success
  end

  test "should get new" do
    get new_message_url
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post messages_url, params: { message: { en_content: @message.en_content, en_name: @message.en_name, hmn_content: @message.hmn_content, hmn_name: @message.hmn_name, vi_content: @message.vi_content, vi_name: @message.vi_name, zh_cn_content: @message.zh_cn_content, zh_cn_name: @message.zh_cn_name, zh_tw_content: @message.zh_tw_content, zh_tw_name: @message.zh_tw_name } }
    end

    assert_redirected_to message_url(Message.last)
  end

  test "should show message" do
    get message_url(@message)
    assert_response :success
  end

  test "should get edit" do
    get edit_message_url(@message)
    assert_response :success
  end

  test "should update message" do
    patch message_url(@message), params: { message: { en_content: @message.en_content, en_name: @message.en_name, hmn_content: @message.hmn_content, hmn_name: @message.hmn_name, vi_content: @message.vi_content, vi_name: @message.vi_name, zh_cn_content: @message.zh_cn_content, zh_cn_name: @message.zh_cn_name, zh_tw_content: @message.zh_tw_content, zh_tw_name: @message.zh_tw_name } }
    assert_redirected_to message_url(@message)
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete message_url(@message)
    end

    assert_redirected_to messages_url
  end
end
