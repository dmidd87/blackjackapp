class PagesController < ApplicationController

  def index
    @deck = Game.last.cards
  end
end
