class Chat::Message < ApplicationRecord

  belongs_to :user
  belongs_to :conversation

  after_create_commit { Chat::MessageBroadcastJob.perform_later(self) }
end