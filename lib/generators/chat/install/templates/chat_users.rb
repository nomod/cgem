class ChatUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_users do |t|
      t.string :user_name
      t.string :chat_token, index: true
      t.boolean :admin, default: false
      t.boolean :operator, default: false

      t.timestamps
    end
  end
end

