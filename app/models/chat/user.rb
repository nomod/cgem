class Chat::User < ApplicationRecord

  has_many :messages
  has_many :conversations, foreign_key: :sender_id

  validates_presence_of :user_name, message: 'Заполните поле'
  validates_length_of :user_name, minimum: 3, message: 'Минимальная длина 3 символа'

  ONLINE_PERIOD = 5.minutes

  scope :online, -> { where('updated_at > ?', ONLINE_PERIOD.ago) }

  def online?
    updated_at > ONLINE_PERIOD.ago
  end


end
