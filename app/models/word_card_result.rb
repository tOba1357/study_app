# == Schema Information
#
# Table name: word_card_results
#
#  id           :bigint           not null, primary key
#  remember     :boolean          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  word_card_id :integer          not null
#
# Indexes
#
#  index_word_card_results_on_word_card_id_and_created_at  (word_card_id,created_at)
#

class WordCardResult < ApplicationRecord
  belongs_to :word_card
  after_save -> do
    summary = WordCardResultSummary.find_or_initialize_by(word_card_id: word_card_id)
    summary.result_count = WordCardResult.where(word_card_id: word_card_id).count
    summary.remember_count = WordCardResult
                                 .where(word_card_id: word_card_id)
                                 .where(remember: true)
                                 .count
    summary.save!
  end
end
