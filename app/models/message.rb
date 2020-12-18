class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: true
  #空のメッセージは表示しない
end
