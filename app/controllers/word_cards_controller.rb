class WordCardsController < ApplicationController
  def index
    @word_cards = current_user.word_cards
  end

  def show
    redirect_to word_cards_path
  end

  def new
    @word_card = current_user.word_cards.build
  end

  def create
    @word_card = current_user.word_cards.build(word_card_params)
    if @word_card.save
      redirect_to @word_card
    else
      render :new
    end
  end

  def edit
    @word_card = current_user.word_cards.find_by(id: params[:id])
  end

  def update
    @word_card = current_user.word_cards.find_by(id: params[:id])
    if @word_card.update(word_card_params)
      redirect_to @word_card
    else
      render :edit
    end
  end

  def destroy
    @word_card = current_user.word_cards.find_by(id: params[:id])
    @word_card.delete
    redirect_to word_cards_path
  end

  def study
    gon.word_cards = current_user.word_cards
  end

  private
    def word_card_params
      params.require(:word_card).permit(:word, :description)
    end
end
