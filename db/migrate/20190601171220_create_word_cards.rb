class CreateWordCards < ActiveRecord::Migration[5.2]
  def change
    create_table :word_cards do |t|
      t.integer :user_id, null: false, index: true
      t.text :word, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
