namespace :sprite do
  desc "generate some sprite css, yo!"
  task :generate do
    ["clubs", "diamonds", "hearts", "spades"].each.with_index do |suit, suit_index|
      ['ace', 'king', 'queen', 'jack'].each.with_index do |number, number_index|
        puts ".#{number}-#{suit} { background-position: #{number_index} $card-height * #{suit_index}; }"
      end
    end
  end
end
