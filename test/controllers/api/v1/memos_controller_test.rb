require "test_helper"

class Api::V1::MemosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_memo = api_v1_memos(:one)
  end

  test "should get index" do
    get api_v1_memos_url, as: :json
    assert_response :success
  end

  test "should create api_v1_memo" do
    assert_difference("Api::V1::Memo.count") do
      post api_v1_memos_url, params: { api_v1_memo: { created_by: @api_v1_memo.created_by, memo: @api_v1_memo.memo, title: @api_v1_memo.title, user_sub: @api_v1_memo.user_sub } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_memo" do
    get api_v1_memo_url(@api_v1_memo), as: :json
    assert_response :success
  end

  test "should update api_v1_memo" do
    patch api_v1_memo_url(@api_v1_memo), params: { api_v1_memo: { created_by: @api_v1_memo.created_by, memo: @api_v1_memo.memo, title: @api_v1_memo.title, user_sub: @api_v1_memo.user_sub } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_memo" do
    assert_difference("Api::V1::Memo.count", -1) do
      delete api_v1_memo_url(@api_v1_memo), as: :json
    end

    assert_response :no_content
  end
end
