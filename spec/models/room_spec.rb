require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#create' do
    before do
      @room = FactoryBot.build(:room)
    end

    it "nameの値が存在すれば登録できること" do
       @room.name = "a"
       expect(@room).to be_valid
       #be_validであることに注意する

    end

    it "nameが空では登録できないこと" do
       @room.name = nil
       @room.valid?
       expect(@room.errors.full_messages).to include("Name can't be blank")
       

    end
  end
end