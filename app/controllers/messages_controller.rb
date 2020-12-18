class MessagesController < ApplicationController 
  def index
    @message = Message.new
    @room    = Room.find(params[:room_id])
    #チャットルームに紐付いている全てのメッセージを@messagesと定義する
    #一覧画面で表示するメッセージ情報にはユーザー情報も紐付いて表示される
    #この場合、メッセージに紐付くユーザー情報の取得に、メッセージの数と
    #同じ回数のアクセスが必要になるのでN＋１問題が発生する
    #includes(:user)と記述することにより、ユーザー情報を
    #一度のアクセスでまとめて取得できる
    @messages = @room.messages.includes(:user)
  #roomはmessageにネストされているため
  #パスにroom:idが含まれているそれをfindするため
  #Room.find(params[:room_id])という表記になる
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
       redirect_to room_messages_path(@room)
       #メッセージの保存に成功した場合、redirect_toメソッドを用いて
       #messagesコントローラーのindexアクションに再度リクエストを送信し
       #インスタンス変数を生成する
    else
     @messages = @room.messages.includes(:user)
     #また投稿に失敗したときの処理にも、同様に@messagesを定義した
     #renderを用いることで、投稿に失敗した@messagesの情報を保持しつつ
     #index.html.erbを参照することができる
     #しかしながらそのときに@messagesが定義されていないとエラーになってしまう
     #そこでindexアクションと同様に@messagesを定義する必要がある
     render :index
     #メッセージの保存に失敗した場合、renderメソッドを用いてindexアクションの
     #index.html.erbを表示するように指定しているこのとき、indexアクションの
     #インスタンス変数はそのままindex.html.erbに渡され、同じページに戻る
    end
  end

 private

 def message_params
 params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
 end
end



