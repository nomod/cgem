module Chat

  class SessionsController < ApplicationController

    def new

    end

    def create
      @operator = Chat::Operator.find_by(email: params[:session][:email].downcase)

      #если оператор с такой почтой существует и у него в базе есть введенный пароль
      if @operator && @operator.authenticate(params[:session][:password])
        @user = @operator.user
        sign_in(@user, @operator)
        redirect_to main_app.root_path
      else
        flash.now[:error] = 'Неправильная пара логин/пароль'
        render 'new'
      end
    end

    def destroy
      @operator = Chat::Operator.find_by(user_id: current_user_chat.id)
      sign_out(@operator)
      redirect_to main_app.root_url
    end

  end

end