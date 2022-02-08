require "test_helper"

class HealthwiseArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @healthwise_article = healthwise_articles(:one)
  end

  test "should get index" do
    get healthwise_articles_url
    assert_response :success
  end

  test "should get new" do
    get new_healthwise_article_url
    assert_response :success
  end

  test "should create healthwise_article" do
    assert_difference('HealthwiseArticle.count') do
      post healthwise_articles_url, params: { healthwise_article: { archive: @healthwise_article.archive, array: @healthwise_article.array, category: @healthwise_article.category, en_json: @healthwise_article.en_json, en_title: @healthwise_article.en_title, en_translated: @healthwise_article.en_translated, featured: @healthwise_article.featured, hmn_json: @healthwise_article.hmn_json, hmn_title: @healthwise_article.hmn_title, hmn_translated: @healthwise_article.hmn_translated, hwid: @healthwise_article.hwid, languages: @healthwise_article.languages, type: @healthwise_article.type, vi_json: @healthwise_article.vi_json, vi_title: @healthwise_article.vi_title, vi_translated: @healthwise_article.vi_translated, zh_cn_json: @healthwise_article.zh_cn_json, zh_cn_title: @healthwise_article.zh_cn_title, zh_cn_translated: @healthwise_article.zh_cn_translated, zh_tw_json: @healthwise_article.zh_tw_json, zh_tw_title: @healthwise_article.zh_tw_title, zh_tw_translated: @healthwise_article.zh_tw_translated } }
    end

    assert_redirected_to healthwise_article_url(HealthwiseArticle.last)
  end

  test "should show healthwise_article" do
    get healthwise_article_url(@healthwise_article)
    assert_response :success
  end

  test "should get edit" do
    get edit_healthwise_article_url(@healthwise_article)
    assert_response :success
  end

  test "should update healthwise_article" do
    patch healthwise_article_url(@healthwise_article), params: { healthwise_article: { archive: @healthwise_article.archive, array: @healthwise_article.array, category: @healthwise_article.category, en_json: @healthwise_article.en_json, en_title: @healthwise_article.en_title, en_translated: @healthwise_article.en_translated, featured: @healthwise_article.featured, hmn_json: @healthwise_article.hmn_json, hmn_title: @healthwise_article.hmn_title, hmn_translated: @healthwise_article.hmn_translated, hwid: @healthwise_article.hwid, languages: @healthwise_article.languages, type: @healthwise_article.type, vi_json: @healthwise_article.vi_json, vi_title: @healthwise_article.vi_title, vi_translated: @healthwise_article.vi_translated, zh_cn_json: @healthwise_article.zh_cn_json, zh_cn_title: @healthwise_article.zh_cn_title, zh_cn_translated: @healthwise_article.zh_cn_translated, zh_tw_json: @healthwise_article.zh_tw_json, zh_tw_title: @healthwise_article.zh_tw_title, zh_tw_translated: @healthwise_article.zh_tw_translated } }
    assert_redirected_to healthwise_article_url(@healthwise_article)
  end

  test "should destroy healthwise_article" do
    assert_difference('HealthwiseArticle.count', -1) do
      delete healthwise_article_url(@healthwise_article)
    end

    assert_redirected_to healthwise_articles_url
  end
end
