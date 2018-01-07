module Chat

  module BasicHelper

    # def conversations
    #
    #   #если переменной session[:conversations] не присвоено значение, т.е. она равна nil или false, то нужно присвоить ей [], в противном случае, если у нее есть значение, ничего делать не нужно.
    #   session[:conversations] ||= []
    #
    #   #вынимаем из базы по id диалога (хранится в session[:conversations]) сам диалог, все его сообщения и пользователей, которые учавствуют в диалоге
    #   @conversations = Chat::Conversation.includes(:recipient, :messages).find(session[:conversations])
    #
    # end
    #
    # def all_operators
    #   #выбираем только пользователей-операторов и только тех у кого статус онлайн
    #   @operators = Chat::Operator.joins(:user).where.not("chat_users.operator": false, "chat_operators.status": false).select("chat_users.user_name", "chat_users.id")
    # end
    #
    # def users_online
    #   @users = Chat::User.online.where.not(operator: true)
    # end

  end

end