class ChatMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_messages do |t|
      t.text :body
      t.integer :user_id
      t.references :conversation, foreign_key: true

      t.timestamps
    end
  end
end
