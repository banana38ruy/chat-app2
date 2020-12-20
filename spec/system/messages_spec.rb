require 'rails_helper'

RSpec.describe "メッセージ投稿機能", type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @room_user = FactoryBot.create(:room_user)
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗すること' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # DBに保存されていないことを確認する
      expect {
        find('input[name="commit"]').click
      }.not_to change { Message.count }
      
      #findまず送信ボタンを探す
      #'input[name="commit"]'を .clickする
      #変わらないので .not_to change
      

      # 元のページに戻ってくることを確認する
      expect(current_path).to eq room_messages_path(@room_user.room)
    end
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 値をテキストフォームに入力する
     post = "テスト"
     fill_in 'message_content', with: post
      #fill inで入力する 右の値が実際に入力する数値になる
      #値を代入してそれをはきだす

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
     #数値が変わる場合は .by(1)と表記する [1]じゃないので気をつける

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq room_messages_path(@room_user.room)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
      #page に対して 上で規定した post(テキスト)を持っているか to have_content(post)と表記する

    end

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)
      #左（）にメッセージに紐付いた画像を記入し そのあとのリンク先image_path,を書き後の送信確認の為隠している要素を
      #make_visibule: trueで明らかにする

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      
      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq room_messages_path(@room_user.room)

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")

    end

    it 'テキストと画像の投稿に成功すること' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      
      attach_file('message[image]', image_path, make_visible: true)

      # 値をテキストフォームに入力する
      post = "test"
      fill_in "message_content", with: post
      #withの右が実際に打ち込む内容 今回はpostを代入したものを添えている
      
      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ Message.count }.by(1)
      # ('input[]')という枠になっていることに注意 
      # []の中は[name="commit"]になっている

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
      #"post"ではなく（post)

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")

    end
  end
end