require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path
    #toはいらない visit toはだめ

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    #buildではなくて保存するのでcreate そして（:user)のハッシュをつける
    # サインインページへ移動する
    visit new_user_session_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    #すでに保存されているのでconfirmationはいらない
    #fill_in 'user_email', with: @user.email と左と右で照らし合わせているので注意、, with によって照らし合わせている
    # ログインボタンをクリックする
    click_on("Log in")
    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path

  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
    # トップページに遷移する
      visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
     expect(current_path).to eq new_user_session_path
    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: "test"
    fill_in 'user_password', with: "test"
    # 左が保存されているパスワード 右が照らし合わせるパスワード 右をいじる
    # 右は文字列で入力するので"で囲う
    # ログインボタンをクリックする
    click_on("Log in")
    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq new_user_session_path

  end
end