class ChatOperators < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_operators do |t|
      t.integer :user_id
      t.string :email, index: true, unique: true
      t.string :password_digest
      t.boolean :status, default: false

      t.timestamps
    end
  end
end