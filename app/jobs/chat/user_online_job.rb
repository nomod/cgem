module Chat

  class UserOnlineJob < ApplicationJob
    queue_as :default

    def perform(users_online)
      users = users_online
      render_users(users)
    end

    private

    def render_users(users)
      ApplicationController.render(
          partial: 'chat/users/online',
          locals: { users: users }
      )
    end

  end

end