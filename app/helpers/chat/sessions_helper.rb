module Chat
  module SessionsHelper

    def sign_in(user, operator)

      #смотрим есть ли куки от юзера не оператора
      remember_token_from_cookies = Digest::SHA1.hexdigest(cookies[:chat_token].to_s)
      @current_user_chat = Chat::User.find_by(chat_token: remember_token_from_cookies)

      #если есть, удаляем его
      # if @current_user_chat
      #   @current_user_chat.destroy
      # end

      #авторизуемся
      remember_token = SecureRandom.urlsafe_base64
      cookies.permanent[:chat_token] = remember_token

      #Digest - библиотека, SHA1 - алгоритм хеширования, hexdigest - метод
      #SecureRandom - модуль, urlsafe_base64 - метод возвращает случайную строку длиной в 16 символов
      #SecureRandom.urlsafe_base64 - это сам токен из случайных 16 символов
      #Digest::SHA1.hexdigest - шифруем токен
      user.update_attribute(:chat_token, Digest::SHA1.hexdigest(remember_token))
      operator.update_attribute(:status, true)

    end

    def current_user_chat
      #поиск текущего пользователя в базе
      #выдергиваем из куки токен, шифруем его и ищем такой же в базе
      #to_s - нужен, если куки пустые
      remember_token = Digest::SHA1.hexdigest(cookies[:chat_token].to_s)

      #если @current_user nil, то выдергиваем из базы юзера, иначе возвращаем @current_user
      #@current_user ||= User.find_by(remember_token: remember_token)
      if @current_user_chat.nil?
        @current_user_chat = Chat::User.find_by(chat_token: remember_token)
      else
        @current_user_chat
      end
    end

    def sign_out(operator)
      #создаем новый токен
      remember_token = SecureRandom.urlsafe_base64
      #пишем в базу новый зашифрованный токен User.remember_token
      current_user_chat.update_attribute(:chat_token, Digest::SHA1.hexdigest(remember_token))
      #чистим куки
      cookies.delete(:chat_token)
      operator.update_attribute(:status, false)
    end

    #текущий пользователь админ или нет
    def admin?
      current_user_chat.admin?
    end

  end
end