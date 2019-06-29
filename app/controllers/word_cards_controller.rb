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
    @word_card.update!(deleted_at: Time.zone.now)
    redirect_to word_cards_path
  end

  def study
    gon.word_cards = current_user.word_cards
  end

  def study_word
    r = SimpleRandom.new
    r.set_seed
    @word_card = current_user.word_cards
                     .includes(:word_card_result_summary)
                     .max_by do |word_card|
      summary = word_card.word_card_result_summary
      summary ||= word_card.build_word_card_result_summary(
          {
              remember_count: 0,
              result_count: 0,
          }
      )
      r.beta(summary.result_count - summary.remember_count + 1, summary.remember_count + 1)
    end
    render json: {word_card: @word_card}
  end

  private

  def word_card_params
    params.require(:word_card).permit(:word, :description)
  end
end
