# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class Chat::ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations-#{current_user_chat.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def speak(data)

    message_params = data['message'].each_with_object({}) do |el, hash|
      #в цикле перебор параметров сообщения и запись в базу
      hash[el.values.first] = el.values.last
    end

    Chat::Message.create(message_params)
  end
end
