# rubocop:disable Metrics/BlockLength

require './lib/tictactoe'

describe TicTacToe do
  describe TicTacToe::Board do
    subject(:game_board) { TicTacToe::Board.new }
    let(:player_o) { double('Player O', symbol: 'O') }

    describe '#initialize' do
      it 'initializes a new board with empty cells' do
        expect(game_board.get_cell(0)).to eql(' ')
        expect(game_board.get_cell(1)).to eql(' ')
        expect(game_board.get_cell(2)).to eql(' ')
        expect(game_board.get_cell(3)).to eql(' ')
        expect(game_board.get_cell(4)).to eql(' ')
        expect(game_board.get_cell(5)).to eql(' ')
        expect(game_board.get_cell(6)).to eql(' ')
        expect(game_board.get_cell(7)).to eql(' ')
        expect(game_board.get_cell(8)).to eql(' ')
      end
    end
    describe '#get_cell' do
      it 'returns the value of a cell at a specified index' do
        game_board.instance_variable_set(:@board, ['X'] * 9)
        expect(game_board.get_cell(0)).to eql('X')
      end
    end
    describe '#update_board' do
      it 'updates cell 5 and returns the correct symbol O' do
        game_board.update_board(player_o, 5)
        expect(game_board.get_cell(5)).to eql('O')
      end
    end
    describe '#valid_move?' do
      context 'when the board is empty' do
        empty_board = TicTacToe::Board.new
        it 'returns true for the upper left cell' do
          expect(empty_board.valid_move?(0)).to eql(true)
        end
      end
    end
    describe '#board_full?' do
      context 'when the board is full' do
        full_board = TicTacToe::Board.new
        full_board.instance_variable_set(:@board, ['X'] * 9)

        it 'returns true if the board is full' do
          expect(full_board.board_full?).to eql(true)
        end
      end
      context 'when the board is empty' do
        empty_board = TicTacToe::Board.new

        it 'returns false if the board is empty' do
          expect(empty_board.board_full?).to eql(false)
        end
      end
      describe '#reset_board' do
        it 'resets the board' do
          game_board.reset_board
          expect(game_board.instance_variable_get(:@board)).to eql([' '] * 9)
        end
      end
    end
  end
  describe TicTacToe::Player do
    describe '#make_move' do
      subject(:player_o) { TicTacToe::Player.new('Player O', 'O') }
      context 'when entered a valid move' do
        before do
          allow(player_o).to receive(:puts)
          allow(player_o).to receive(:gets).and_return('9\n')
        end
        it 'returns 8' do
          expect(player_o.make_move).to eql(8)
        end
      end
      context 'when entered a number greater than the maximum' do
        before do
          allow(player_o).to receive(:puts)
          allow(player_o).to receive(:gets).and_return('32\n')
        end
        it 'returns 8' do
          expect(player_o.make_move).to eql(8)
        end
      end
      context 'when entered a number less than the minimum' do
        before do
          allow(player_o).to receive(:puts)
          allow(player_o).to receive(:gets).and_return('-1\n')
        end
        it 'returns 0' do
          expect(player_o.make_move).to eql(0)
        end
      end
    end
  end
  describe TicTacToe::Game do
    describe '#switch_player' do
      context 'when the current player is 1' do
        subject(:player1_game) { TicTacToe::Game.new }

        it 'correctly swaps current_player with player 2' do
          player_two = player1_game.instance_variable_get(:@player2)
          expect { player1_game.switch_player }.to change {
            player1_game.instance_variable_get(:@current_player)
          }.to(player_two)
        end
      end
    end
    describe '#fetch_valid_move' do
      context 'when the player enters a valid move' do
        subject(:game) { TicTacToe::Game.new }
        before do
          allow(game).to receive(:puts)
          allow(game.instance_variable_get(:@current_player)).to receive(:make_move).and_return(3)
        end
        it 'returns 3 the valid move position' do
          expect(game.fetch_valid_move).to eql(3)
        end
      end
      context 'when the player enters an invalid move then a valid move' do
        subject(:game) { TicTacToe::Game.new }
        before do
          allow(game).to receive(:puts)
          board_cells = [' ', ' ', ' ', 'X', ' ', ' ', ' ', ' ', ' ']
          game.instance_variable_get(:@board).instance_variable_set(:@board, board_cells)
          allow(game.instance_variable_get(:@current_player)).to receive(:make_move).and_return(3, 8)
        end
        it 'returns 8 the valid move position' do
          expect(game.fetch_valid_move).to eql(8)
        end
      end
    end
    describe '#check_winner' do
      context 'when player x has won' do
        subject(:player_x_game) { TicTacToe::Game.new }
        before do
          board_cells = ['X', ' ', ' ', ' ', 'X', ' ', ' ', ' ', 'X']
          player_x_game.instance_variable_get(:@board).instance_variable_set(:@board, board_cells)
        end
        it 'returns sets @winner to @player1' do
          expect(player_x_game.check_winner).to eql(true)
        end
      end
      context 'when player o has won' do
        subject(:player_o_game) { TicTacToe::Game.new }
        before do
          board_cells = [' ', 'O', ' ', ' ', 'O', '', ' ', 'O', ' ']
          player_o_game.instance_variable_get(:@board).instance_variable_set(:@board, board_cells)
        end
        it 'returns sets @winner to @player1' do
          expect(player_o_game.check_winner).to eql(true)
        end
      end
    end
  end
end
