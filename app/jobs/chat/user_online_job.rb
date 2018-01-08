module Chat

  class UserOnlineJob < ApplicationJob
    queue_as :default

    def perform(all_operators, users_online)
      @users = users_online
      @all_operators = all_operators

      @all_operators.each do |operator|
        broadcast_to_operators(operator, @users)
      end

    end

    private

    def broadcast_to_operators(operator, users)
      ActionCable.server.broadcast(
          "conversations-#{operator.id}",
          users: render_users(users)
      )
    end

    def render_users(users)
      ApplicationController.render(
          partial: 'chat/users/online',
          locals: { users: users }
      )
    end

  end

end