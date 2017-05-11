require 'rails_helper'

describe Card do
  let(:card) {Card.new(color: 'red', symbol: 'diamonds', number: 2, shading: 'solid')}

  describe "a card" do
    context "when a card has valid inputs" do
      it "has a color" do
        expect(card.color).to eq "red"
      end
      it "has a symbol" do
        expect(card.symbol).to eq "diamonds"
      end
      it "has a number" do
        expect(card.number).to eq '2'
      end
      it "has a shading" do
        expect(card.shading).to eq "solid"
      end
    end
  end
end
