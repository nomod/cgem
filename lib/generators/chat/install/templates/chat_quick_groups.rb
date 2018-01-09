class ChatQuickGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_quick_groups do |t|
      t.text :quick_group_name

      t.timestamps
    end
  end
end
