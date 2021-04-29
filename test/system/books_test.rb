# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    books(:cherry_book)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本'
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'
    fill_in 'タイトル', with: 'Ruby超入門'
    fill_in 'メモ', with: 'すごくわかりやすい！！'
    fill_in '著者', with: 'igaiga'
    click_on '登録する'
    assert_text '本が作成されました。'
    assert_text 'Ruby超入門'
    assert_text 'すごくわかりやすい！！'
    assert_text 'igaiga'
    click_on '戻る'
  end

  test 'updating a Book' do
    visit books_url
    click_on '編集', match: :prefer_exact
    fill_in 'タイトル', with: '新しいLinuxの教科書'
    fill_in 'メモ', with: 'とてもわかりやすい！'
    fill_in '著者', with: 'miyake,osumi'
    click_on '更新する'
    assert_text '新しいLinuxの教科書'
    assert_text 'とてもわかりやすい！'
    assert_text 'miyake,osumi'
    assert_text '本が更新されました。'
    click_on '戻る'
  end

  test 'destroying a Book' do
    visit books_url
    page.accept_confirm do
      click_on '削除', match: :first
    end
    assert_text '本が削除されました。'
  end
end
