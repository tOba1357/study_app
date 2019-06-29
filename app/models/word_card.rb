# == Schema Information
#
# Table name: word_cards
#
#  id          :bigint           not null, primary key
#  deleted_at  :datetime
#  description :text             not null
#  word        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_word_cards_on_user_id  (user_id)
#

class WordCard < ApplicationRecord
  belongs_to :user
  default_scope -> { where(deleted_at: nil)}
  has_many :word_card_results
  has_one :word_card_result_summary
end
