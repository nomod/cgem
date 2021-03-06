# frozen_string_literal: true

require "rails/generators/base"
require "rails/generators/active_record"
require "rails/generators/migration"

module Chat
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../templates", __FILE__)


      def add_helper
        file = "app/controllers/application_controller.rb"
        after = "class ApplicationController < ActionController::Base\n"
        inject_into_file file, after: after do
          "  helper Chat::Engine.helpers\n"
        end
      end

      def add_before
        file = "app/controllers/application_controller.rb"
        after = "class ApplicationController < ActionController::Base\n"
        inject_into_file file, after: after do
          "  before_action :current_user_chat, :check_session, :user_activity\n"
        end
      end

      def add_after
        file = "app/controllers/application_controller.rb"
        after = "class ApplicationController < ActionController::Base\n"
        inject_into_file file, after: after do
          "  after_action :online_info\n"
        end
      end

      def add_chat_status_migration
        migration_template "chat_users.rb", "db/migrate/chat_users.rb"
        migration_template "chat_operators.rb", "db/migrate/chat_operators.rb"
        migration_template "chat_conversations.rb", "db/migrate/chat_conversations.rb"
        migration_template "chat_messages.rb", "db/migrate/chat_messages.rb"
        migration_template "chat_quick_phrases.rb", "db/migrate/chat_quick_phrases.rb"
        migration_template "chat_quick_groups.rb", "db/migrate/chat_quick_groups.rb"
      end

      def add_chat_route
        route "mount Chat::Engine, at: '/chat'"
      end

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

    end
  end
end
