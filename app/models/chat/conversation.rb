class Chat::Conversation < ApplicationRecord

  has_many :messages, dependent: :destroy

  belongs_to :sender, foreign_key: :sender_id, class_name: Chat::User
  belongs_to :recipient, foreign_key: :recipient_id, class_name: Chat::User

  #валидация уникальности - чтобы была только одна запись вида: отправитель-получатель
  validates :sender_id, uniqueness: { scope: :recipient_id }

  def self.between(sender_id, recipient_id)
    where( sender_id: sender_id, recipient_id: recipient_id).or(where(sender_id: recipient_id, recipient_id: sender_id) )
  end

  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    #вернуть если не пустой
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def opposed_user(user)

    #(условие) ? действие1 : действие2
    user == recipient ? sender : recipient

    #если писать по старинке
    # if user == recipient
    #   sender
    # else
    #   recipient
    # end

  end
end