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

require 'test_helper'

class WordCardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
