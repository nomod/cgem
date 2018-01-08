# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class Chat::OnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "onlines-#{current_user_chat.id}"
  end

  def unsubscribed
    stop_all_streams
  end

end