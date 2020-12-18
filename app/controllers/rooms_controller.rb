class RoomsController < ApplicationController
  def new
    #チャットルームの新規作成なので「new」アクションを定義する
    @room = Room.new
    #また、form_withにわたす引数として、値が空のRoomインスタンスを
   #@roomに代入している
  end
 
end
