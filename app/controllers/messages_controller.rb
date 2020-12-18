class MessagesController < ApplicationController 
  def index
    @message = Message.new
    @room    = Room.find(params[:room_id])
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
     render :index
     #メッセージの保存に失敗した場合、renderメソッドを用いてindexアクションの
     #index.html.erbを表示するように指定しているこのとき、indexアクションの
     #インスタンス変数はそのままindex.html.erbに渡され、同じページに戻る
    end
  end

 private

 def message_params
 params.require(:message).permit(:content).merge(user_id: current_user.id)
 end
end



