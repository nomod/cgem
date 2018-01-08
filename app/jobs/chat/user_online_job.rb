module Chat

  class UserOnlineJob < ApplicationJob
    queue_as :default

    def perform(all_operators, users_online)
      puts "start UserOnlineJob"

      @all_operators = Chat::Operator.where(id: all_operators)
      @users = Chat::User.where(id: users_online)

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