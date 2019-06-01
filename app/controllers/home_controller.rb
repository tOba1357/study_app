class HomeController < ApplicationController
  def index
    redirect_to word_cards_path if current_user.present?
  end
end