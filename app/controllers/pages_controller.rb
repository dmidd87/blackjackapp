class PagesController < ApplicationController

  def index

    deck = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]
    suits = ["S","C","H","D"]

    @deck = deck
    @suits = [suits]

  end

end
