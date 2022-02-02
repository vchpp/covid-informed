require "application_system_test_case"

class HealthwiseArticlesTest < ApplicationSystemTestCase
  setup do
    @healthwise_article = healthwise_articles(:one)
  end

  test "visiting the index" do
    visit healthwise_articles_url
    assert_selector "h1", text: "Healthwise Articles"
  end

  test "creating a Healthwise article" do
    visit healthwise_articles_url
    click_on "New Healthwise Article"

    check "Archive" if @healthwise_article.archive
    fill_in "Array", with: @healthwise_article.array
    fill_in "Category", with: @healthwise_article.category
    fill_in "En json", with: @healthwise_article.en_json
    fill_in "En title", with: @healthwise_article.en_title
    check "En translated" if @healthwise_article.en_translated
    check "Featured" if @healthwise_article.featured
    fill_in "Hmn json", with: @healthwise_article.hmn_json
    fill_in "Hmn title", with: @healthwise_article.hmn_title
    check "Hmn translated" if @healthwise_article.hmn_translated
    fill_in "Hwid", with: @healthwise_article.hwid
    fill_in "Languages", with: @healthwise_article.languages
    fill_in "Type", with: @healthwise_article.type
    fill_in "Vi json", with: @healthwise_article.vi_json
    fill_in "Vi title", with: @healthwise_article.vi_title
    check "Vi translated" if @healthwise_article.vi_translated
    fill_in "Zh cn json", with: @healthwise_article.zh_cn_json
    fill_in "Zh cn title", with: @healthwise_article.zh_cn_title
    check "Zh cn translated" if @healthwise_article.zh_cn_translated
    fill_in "Zh tw json", with: @healthwise_article.zh_tw_json
    fill_in "Zh tw title", with: @healthwise_article.zh_tw_title
    check "Zh tw translated" if @healthwise_article.zh_tw_translated
    click_on "Create Healthwise article"

    assert_text "Healthwise article was successfully created"
    click_on "Back"
  end

  test "updating a Healthwise article" do
    visit healthwise_articles_url
    click_on "Edit", match: :first

    check "Archive" if @healthwise_article.archive
    fill_in "Array", with: @healthwise_article.array
    fill_in "Category", with: @healthwise_article.category
    fill_in "En json", with: @healthwise_article.en_json
    fill_in "En title", with: @healthwise_article.en_title
    check "En translated" if @healthwise_article.en_translated
    check "Featured" if @healthwise_article.featured
    fill_in "Hmn json", with: @healthwise_article.hmn_json
    fill_in "Hmn title", with: @healthwise_article.hmn_title
    check "Hmn translated" if @healthwise_article.hmn_translated
    fill_in "Hwid", with: @healthwise_article.hwid
    fill_in "Languages", with: @healthwise_article.languages
    fill_in "Type", with: @healthwise_article.type
    fill_in "Vi json", with: @healthwise_article.vi_json
    fill_in "Vi title", with: @healthwise_article.vi_title
    check "Vi translated" if @healthwise_article.vi_translated
    fill_in "Zh cn json", with: @healthwise_article.zh_cn_json
    fill_in "Zh cn title", with: @healthwise_article.zh_cn_title
    check "Zh cn translated" if @healthwise_article.zh_cn_translated
    fill_in "Zh tw json", with: @healthwise_article.zh_tw_json
    fill_in "Zh tw title", with: @healthwise_article.zh_tw_title
    check "Zh tw translated" if @healthwise_article.zh_tw_translated
    click_on "Update Healthwise article"

    assert_text "Healthwise article was successfully updated"
    click_on "Back"
  end

  test "destroying a Healthwise article" do
    visit healthwise_articles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Healthwise article was successfully destroyed"
  end
end
