class CreateWordCardResults < ActiveRecord::Migration[5.2]
  def change
    create_table :word_card_results do |t|
      t.integer :word_card_id, null: false
      t.boolean :remember, null: false
      t.timestamps null: false
    end
    add_index :word_card_results, [:word_card_id, :created_at]
  end
end
