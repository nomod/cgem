module Chat
  class Engine < ::Rails::Engine
    isolate_namespace Chat


    ActionController::Base.class_eval do
      def check_session

        remember_token_from_cookies = Digest::SHA1.hexdigest(cookies[:chat_token].to_s)
        @current_user_chat = Chat::User.find_by(chat_token: remember_token_from_cookies)

        if @current_user_chat.nil?

          @last_user = Chat::User.last

          if @last_user.nil?
            @last_user_id = 1
          else
            @last_user_id = Chat::User.last.id
          end

          remember_token = SecureRandom.urlsafe_base64
          cookies.permanent[:chat_token] = remember_token
          @user = Chat::User.create(user_name: "Клиент #{@last_user_id + 1}", chat_token: Digest::SHA1.hexdigest(remember_token))

        else
          @current_user_chat
        end

      end
    end

  end
end
