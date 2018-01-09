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
          "  before_action :current_user_chat, :check_session, :user_activity\n"
          "  after_action :online_info\n"
        end
      end

      def add_chat_status_migration
        migration_template "create_chat.rb", "db/migrate/create_chat.rb"
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
