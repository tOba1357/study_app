class WordCard < ApplicationRecord
  belongs_to :user
  has_many :word_card_results
end
