module Chat

  class ConversationsController < ApplicationController

    def index
      #если текущий юзер - админ, то получаем инфу по всем диалогам
      if !current_user_chat.nil? && admin?
        @сonversations = Conversation.all.order(:id)
      else
        flash[:notice] = 'Авторизуйтесь для продолжения!'
        redirect_to operator_signin_url
      end
    end

    def show

      @conversation = Chat::Conversation.find_by(id: params[:id])
      @messages = Chat::Message.all.where(conversation_id: @conversation.id)

    end


    def create
      #текущий диалог
      @conversation = Chat::Conversation.get(chat.current_user_chat.id, params[:user_id])
      #его сообщения
      @messages = Chat::Message.all.where(conversation_id: @conversation.id)
      #собеседник
      @opp_user = @conversation.opposed_user(current_user_chat)

      #add_to_conversations unless conversated?

      if conversated?
        add_to_conversations
      end

      respond_to do |format|
        format.json { render json: {conversation: @conversation, user: current_user_chat, messages: @messages, opposed_user: @opp_user} }
      end
    end

    def close
      @conversation = Chat::Conversation.find(params[:id])

      session[:conversations].delete(@conversation.id)

      respond_to do |format|
        format.json { render json: {conversation: @conversation} }
      end
    end

    private

    def add_to_conversations
      session[:conversations] ||= []
      session[:conversations] << @conversation.id
    end

    def conversated?
      #проверяем наличие id беседы в session[:conversations]
      session[:conversations].include?(@conversation.id)
    end
  end

end