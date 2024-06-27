class CreateMemories < ActiveRecord::Migration[7.1]
  def change
    create_table :memories do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :memories, [:user_id, :created_at]
  end
end
