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

require 'test_helper'

class WordCardResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
