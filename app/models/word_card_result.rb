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
  after_commit -> do
    begin
      ActiveRecord::Base.transaction do
        user = word_card.user
        conn = ActiveRecord::Base.connection
        sql = <<-sql
    delete from word_card_result_summaries 
    where word_card_id in (select id from word_cards where user_id = ? and deleted_at is null)
        sql
        sql = ActiveRecord::Base.send(
            :sanitize_sql_array,
            [sql, user.id]
        )
        conn.execute(sql)

        sql = <<-sql
insert into word_card_result_summaries (word_card_id, result_count, remember_count, created_at, updated_at)
select 
  word_card_id,
  sum(case when remember then 1 else 0 end) remember_count,
  count(*) result_count,
  current_timestamp,
  current_timestamp
from (
  select *
  from word_card_results
  where word_card_id in (select id from word_cards where user_id = ? and deleted_at is null)
  order by created_at desc
  limit ?) sliced
group by word_card_id;
        sql
        sql = ActiveRecord::Base.send(
            :sanitize_sql_array,
            [sql, user.id, user.word_cards.count * 2]
        )
        conn.execute(sql)
      end
    end
 end
end
