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
