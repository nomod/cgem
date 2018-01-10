module Chat

  class UserOnlineJob < ApplicationJob
    queue_as :default

    def perform(all_operators, users_online)
      puts "start UserOnlineJob"

      @all_operators_id = Operator::User.where(user_id: all_operators)
      @all_operators = User::User.where(id: @all_operators_id)
      @users = Chat::User.where(id: users_online)

      puts "all_operators: #{@all_operators}"
      puts "users_online: #{@users}"

      @all_operators.each do |operator|
        broadcast_to_operators(operator, @users)
      end

    end

    private

    def broadcast_to_operators(operator, users)
      puts "start broadcast_to_operators"
      ActionCable.server.broadcast(
          "onlines-#{operator.id}",
          users: render_users(users)
      )
    end

    def render_users(users)
      puts "start render_users"
      ApplicationController.render(
          partial: 'chat/users/online',
          locals: { users: users }
      )
    end

  end

end