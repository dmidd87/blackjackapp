class PagesController < ApplicationController

  def index
    @deck = Card.all
  end
end
