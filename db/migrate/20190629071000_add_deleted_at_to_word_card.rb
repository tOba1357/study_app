class AddDeletedAtToWordCard < ActiveRecord::Migration[5.2]
  def change
    add_column :word_cards, :deleted_at, :datetime
  end
end
