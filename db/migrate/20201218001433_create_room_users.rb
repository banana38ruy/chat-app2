class CreateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :room_users do |t|
      t.references :room,  foreign_key: true
      t.references :user,  foreign_key: true
      #今回はnotnull成約じゃなくて
      #外部キー制約を使っているのでnull: false の記載はしなくていい
      t.timestamps
    end
  end
end
