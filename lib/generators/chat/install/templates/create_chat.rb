# frozen_string_literal: true

class CreateChat < ActiveRecord::Migration[5.0]

  def chat_users
    create_table :chat_users do |t|
      t.string :user_name
      t.string :chat_token, index: true
      t.boolean :admin, default: false
      t.boolean :operator, default: false

      t.timestamps
    end
  end

  def chat_operators
    create_table :chat_operators do |t|
      t.integer :user_id
      t.string :email, index: true, unique: true
      t.string :password_digest
      t.boolean :status, default: false

      t.timestamps
    end
  end

  def chat_messages
    create_table :chat_messages do |t|
      t.text :body
      t.integer :user_id
      t.references :chat_conversation, foreign_key: true

      t.timestamps
    end
  end

  def chat_conversations
    create_table :chat_conversations do |t|
      t.integer :recipient_id
      t.integer :sender_id

      t.timestamps
    end
    add_index :chat_conversations, :recipient_id
    add_index :chat_conversations, :sender_id
  end

  def chat_quick_phrases
    create_table :chat_quick_phrases do |t|
      t.text :phrase
      t.integer :quick_group_id

      t.timestamps
    end
  end

  def chat_quick_groups
    create_table :chat_quick_groups do |t|
      t.text :quick_group_name

      t.timestamps
    end
  end


end
