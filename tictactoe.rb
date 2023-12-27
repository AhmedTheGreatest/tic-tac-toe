# frozen_string_literal: true

module TicTacToe
  # A class representing a tic tac toe board
  class Board
    def initialize
      @board = Array.new(9, ' ')
    end

    def get_cell(index)
      @board[index]
    end

    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
      puts '---+---+---'
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]}"
      puts '---+---+---'
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]}"
    end

    def update_board(player, position)
      @board[position] = player.symbol
    end

    def valid_move?(position)
      @board[position] == ' '
    end

    def board_full?
      @board.all? { |cell| cell != ' ' }
    end

    def reset_board
      @board.map! { ' ' }
    end
  end

  # This class represents a player on the tic tac toe board
  class Player
    attr_reader :symbol, :name

    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end

    def make_move
      puts 'Make a move (1-9):'
      input = gets.chomp.to_i
      [[input, 9].min, 1].max - 1
    end
  end

  # This class manages the flow of the game
  class Game
    WINNING_COMBINATIONS = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ].freeze

    def initialize
      @player1 = Player.new('Player 1', 'X')
      @player2 = Player.new('Player 2', 'O')
      @current_player = @player1
      @board = Board.new
    end

    def switch_player
      @current_player = @current_player == @player1 ? @player2 : @player1
    end

    def fetch_valid_move
      position = nil
      loop do
        position = @current_player.make_move
        break if @board.valid_move?(position)

        puts 'Cell is taken!'
      end
      position
    end

    def play
      @board.display_board

      loop do
        position = fetch_valid_move
        @board.update_board(@current_player, position)
        check_tie
        @board.display_board
        switch_player
        break if check_winner
      end

      puts "The winner of this game is #{@winner.name} (#{@winner.symbol})"
    end

    def check_tie
      return unless @board.board_full?

      @board.reset_board
      puts "It's a TIE! Replay The Match!"
    end

    def check_winner
      WINNING_COMBINATIONS.any? do |combination|
        cell1 = @board.get_cell(combination[0])
        cell2 = @board.get_cell(combination[1])
        cell3 = @board.get_cell(combination[2])
        if cell1 != ' ' && cell1 == cell2 && cell2 == cell3
          @winner = cell1 == 'X' ? @player1 : @player2
          true
        end
      end
    end
  end
end

game = TicTacToe::Game.new
game.play
