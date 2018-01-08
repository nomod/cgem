module Chat

  class MessageBroadcastJob < ApplicationJob
    queue_as :default

    def perform(message)
      sender = message.user
      recipient = message.conversation.opposed_user(sender)

      broadcast_to_sender(sender, message)
      broadcast_to_recipient(recipient, message)

    end

    private

    def broadcast_to_sender(user, message)

      puts "start broadcast_to_sender"

      ActionCable.server.broadcast(
          "conversations-#{user.id}",
          message: render_message(message, user),
          conversation_id: message.conversation_id
      )
    end

    def broadcast_to_recipient(user, message)

      puts "start broadcast_to_recipient"

      ActionCable.server.broadcast(
          "conversations-#{user.id}",
          window: render_window(message, message.conversation, user),
          message: render_message(message, user),
          conversation_id: message.conversation_id
      )
    end

    def render_message(message, user)

      puts "start render_message"

      ApplicationController.render(
          partial: 'chat/messages/message',
          locals: { message: message, user: user }
      )
    end

    def render_window(message, conversation, user)

      puts "start render_window"

      ApplicationController.render(
          partial: 'chat/conversations/conversation',
          locals: { message: message, conversation: conversation, user: user }
      )
    end

  end

end