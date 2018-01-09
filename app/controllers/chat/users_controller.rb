module Chat

  class UsersController < ApplicationController

    def index
      @user = Chat::User.new
      #если текущий юзер - админ, то получаем инфу по всем юзерам
      if !current_user_chat.nil? && admin?
        @users = Chat::User.all.order(:id)
      else
        flash[:notice] = 'Авторизуйтесь для продолжения!'
        redirect_to operator_signin_url
      end
    end

    def new
      @user = Chat::User.new
    end

    def show

    end

    def create

      #регистрация оператора
      @user = current_user_chat

      if @user.update_attributes(user_name: params[:user_name], operator: true)

        @operator = Operator.new(user_id: @user.id, email: params[:email], password: params[:password])

        if @operator.save
          redirect_to operator_signin_path
        end

      else
        flash[:error] = 'Что то пошло не так!'
        render 'new'
      end
    end

    # def update
    #   if @user.update_attributes(operator_params)
    #     flash[:success] = 'Профиль обновлен!'
    #     redirect_to @user
    #   else
    #     render 'edit'
    #   end
    # end


  end

end