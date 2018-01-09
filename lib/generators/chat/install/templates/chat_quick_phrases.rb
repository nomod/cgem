class ChatQuickPhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_quick_phrases do |t|
      t.text :phrase
      t.integer :quick_group_id

      t.timestamps
    end
  end
end
