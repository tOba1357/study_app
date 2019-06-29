# == Schema Information
#
# Table name: word_card_result_summaries
#
#  id             :bigint           not null, primary key
#  remember_count :integer          not null
#  result_count   :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  word_card_id   :integer          not null
#
# Indexes
#
#  index_word_card_result_summaries_on_word_card_id  (word_card_id) UNIQUE
#

class WordCardResultSummary < ApplicationRecord
  belongs_to :word_card
end
