module Chat

  class WelcomeJob < ApplicationJob
    queue_as :default

    def perform(sender_id, conversation_id)

        @message = Message.new(user_id: sender_id, body: 'Могу я Вам чем то помочь?', conversation_id: conversation_id)
        @message.save

    end

  end

end