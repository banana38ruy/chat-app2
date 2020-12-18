class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, unless: :was_attached?
  #空のメッセージは表示しない
  def was_attached?
    self.image.attached?
  end
end
