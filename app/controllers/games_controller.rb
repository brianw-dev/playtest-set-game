class GamesController < ApplicationController

  include GamesHelper

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new
    @game.add_cards
    @game.guess = []
    @game.cards = @game.cards.shuffle
    if @game.save
      redirect_to edit_game_path(@game)
    else
      render :new, status: 422
    end
  end

  def edit
    @game = Game.find(params[:id])
    @cards = @game.cards.first(12).map {|card| Card.find(card)}
  end

  def update
    @game = Game.find(params[:id])
    @cards = @game.cards.first(12).map {|card| Card.find(card)}
    @game.guess << params[:game][:selected_card]
    @game.save
    @guesses = @game.guess.map {|guess| Card.find(guess)}
    if @game.guess.length == 3 && is_a_set?(@guesses)
      @game.cards = @game.cards - @game.guess
      @game.guess = []
      @game.save
      redirect_to edit_game_path(@game)
    else
      render :edit
    end
  end
end
