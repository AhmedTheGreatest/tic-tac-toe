# frozen_string_literal: true

# A Tic Tac Toe game
module TicTacToe
  # A class representing a tic tac toe board
  class Board
    def initialize
      # Creating the board which is an array of 9 cells
      @board = Array.new(9, ' ')
    end

    # This is a getter method for a cell
    def get_cell(index)
      @board[index]
    end

    # Displays the Tic Tac Toe board
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
      puts '---+---+---'
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]}"
      puts '---+---+---'
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]}"
    end

    # Updates the board at position with the player symbol
    def update_board(player, position)
      @board[position] = player.symbol
    end

    # Returns if a move can played on the given position
    def valid_move?(position)
      @board[position] == ' '
    end

    # Returns if the board is full
    def board_full?
      @board.all? { |cell| cell != ' ' }
    end

    # Resets / Clears the board for next game
    def reset_board
      @board.map! { ' ' }
    end
  end

  # This class represents a player on the tic tac toe board
  class Player
    # Getter methods for the player symbol and name
    attr_reader :symbol, :name

    def initialize(name, symbol)
      @name = name
      @symbol = symbol
    end

    # Gets a move from a player
    def make_move
      puts 'Make a move (1-9):'
      input = gets.chomp.to_i
      [[input, 9].min, 1].max - 1
    end
  end

  # This class manages the flow of the game
  class Game
    # All possible tic tac toe winning combinations
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

    # Switch the current player from player1 to player2 or vice-versa
    def switch_player
      @current_player = @current_player == @player1 ? @player2 : @player1
    end

    # Validate the move from the player (Checks if the move position cell is taken)
    def fetch_valid_move
      position = nil
      # Loop until the player has made a valid move
      loop do
        position = @current_player.make_move
        break if @board.valid_move?(position)

        puts 'Cell is taken!'
      end
      position
    end

    # Plays a game of Tic Tac Toe
    def play
      @board.display_board

      # Loops until the game is finished
      loop do
        position = fetch_valid_move # Fetches a valid move from the player
        @board.update_board(@current_player, position) # Updates the board with that move
        check_tie # Checks if the game is a tie
        @board.display_board # Displays / Updates the board
        switch_player # Switches the current player i.e Changes Turn

        break if check_winner # If 1 player has won exit the loop
      end

      #  Prints a game won message
      puts "The winner of this game is #{@winner.name} (#{@winner.symbol})"
    end

    # Checks & Handles if a game is a tie
    def check_tie
      # Returns if the board is not full
      return unless @board.board_full?

      # Resets the board and print a tie message
      @board.reset_board
      puts "It's a TIE! Replay The Match!"
    end

    # Check if someone has won the game
    def check_winner
      # Loops over all the winning combinations and if they match they current board return true
      WINNING_COMBINATIONS.any? do |combination|
        cell1 = @board.get_cell(combination[0])
        cell2 = @board.get_cell(combination[1])
        cell3 = @board.get_cell(combination[2])
        if cell1 != ' ' && cell1 == cell2 && cell2 == cell3
          @winner = cell1 == 'X' ? @player1 : @player2 # Sets the winner instance variable to the winner
          true
        end
      end
    end
  end
end
