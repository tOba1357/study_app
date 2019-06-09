class CreateWordCardResultSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :word_card_result_summaries do |t|
      t.integer :word_card_id, null: false
      t.integer :result_count, null: false
      t.integer :remember_count, null: false

      t.timestamps
    end
    add_index :word_card_result_summaries, :word_card_id, unique: true
  end
end
