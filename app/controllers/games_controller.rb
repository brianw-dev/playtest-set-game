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
    @game.initial_deck
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
    @cards = display(@game)
    p find_set(@cards)
  end

  def update
    @game = Game.find(params[:id])
    @cards = display(@game)
    p find_set(@cards)
    @game.guess << params[:game][:selected_card]
    @game.save
    @guesses = convert_guesses(@game)
    if @game.guess.length == 3 && is_a_set?(@guesses)

      @game.cards = @game.cards - @game.guess
      @game.update_attributes({guess: [], points: @game.points + 10})
      flash[:notice] = "You found a set! (:"
      redirect_to edit_game_path(@game)
    elsif @game.guess.length >= 3
      @game.update_attributes({guess: []})
      flash[:notice] = "Not a set, try again 😞 "
      render :edit
    else
      flash[:notice] = nil
      render :edit
    end
  end
end
