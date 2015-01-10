class PagesController < ApplicationController

  def index
    unless Game.first.nil?
      @deck = Game.last.cards
    end
  end
end
