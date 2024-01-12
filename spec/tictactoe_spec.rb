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
end
