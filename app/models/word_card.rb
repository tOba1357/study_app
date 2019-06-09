class WordCard < ApplicationRecord
  belongs_to :user
  has_many :word_card_results
  has_one :word_card_result_summary
end
