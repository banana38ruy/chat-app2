class RoomsController < ApplicationController
  def new
    #チャットルームの新規作成なので「new」アクションを定義する
    @room = Room.new
    #また、form_withにわたす引数として、値が空のRoomインスタンスを
   #@roomに代入している
  end

def index
end

def create
  @room = Room.new(room_params)
  if @room.save
    redirect_to root_path
  else
    render :new
  end
end

def destroy
  room = Room.find(params[:id])
  room.destroy
  redirect_to root_path
end
  
  private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
    #要求している:roomはモデル名 :roomのなかの:nameの中のuser_ids:の中の[]というイメージ
  end
end
