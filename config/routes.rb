Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create] do
     resources :messages, only: [:index, :create]
  end
 #新規チャットルームの作成で動くアクションは「new」と「create」のみ
 #メッセージを投稿する際には、どのルームで投稿されたメッセージなのかを
 #パスから判断できるようにしたいので、ルーティングのネストを利用する
 #こうすることによってroomsが親、messageが子という親子関係になるので
 #チャットルームに属しているメッセージという意味になる
  
end
