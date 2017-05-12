class GamesController < ApplicationController

  include GamesHelper

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
    redirect_to edit_game_path
  end

  def create
    @game = Game.new
    @game.initial_deck
    @game.cards = @game.cards.shuffle
    if current_user
      @game.user = current_user
    end
    if @game.save
      redirect_to edit_game_path(@game)
    else
      redirect_to new_user_path
    end
  end

  def edit
    @game = Game.find(params[:id])
    @cards = display(@game)
  end

  def update
    @game = Game.find(params[:id])
    @cards = display(@game)
    if params[:game][:add_card] == "3" && @game.cards_shown <= 18
        @game.update_attributes({cards_shown: @game.cards_shown + 3})
        @cards = display(@game)
        render :edit
    elsif params[:game][:find_set] == "💩"
      @solution = find_set(@cards)
      if @solution == nil  && @game.cards.count < 12
        flash[:notice] = "Game Over, no more SETs!"
      elsif @solution == nil
        flash[:notice] = "No available SETs, please add cards"
      end
      render :edit
    elsif !@game.guess.include?(params[:game][:selected_card])
      @game.guess << params[:game][:selected_card]
      @game.save
      @guesses = convert_guesses(@game)
      if @game.guess.length == 3 && is_a_set?(@guesses)
        @game.cards = @game.cards - @game.guess
        @game.update_attributes({guess: [], points: @game.points + 10})
        if @game.cards_shown > 12
          @game.update_attributes({cards_shown: @game.cards_shown - 3})
        end
        flash[:notice] = "🙌 You found a set! 🎉"
        redirect_to edit_game_path(@game)
      elsif @game.guess.length >= 3
        @game.update_attributes({guess: []})
        flash[:notice] = "Not a set, try again 😞"
        render :edit
      else
        flash[:notice] = nil
        render :edit
      end
    end
  end
end
