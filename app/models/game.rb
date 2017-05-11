class Game < ApplicationRecord

  def add_cards
    self.cards = []
    i = 1
    81.times do
      self.cards << i
      i += 1
    end
  end

end
