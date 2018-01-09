class ChatConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_conversations do |t|
      t.integer :recipient_id
      t.integer :sender_id

      t.timestamps
    end
    add_index :chat_conversations, :recipient_id
    add_index :chat_conversations, :sender_id
  end
end
