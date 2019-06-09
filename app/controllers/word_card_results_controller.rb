class WordCardResultsController < ApplicationController
  def create
    @word_card = WordCard.find_by!(id: params[:word_card_id])
    @word_card.word_card_results.create(remember: params[:remember])
    head :ok
  end
end