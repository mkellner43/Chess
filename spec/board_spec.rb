require_relative '../main'

describe Board do

  subject(:board) { described_class.new }
  let(:board_render) {  BoardRender.new(board) }

  describe '#check?' do

    context 'when enemy is in check' do

      before do
        board.set_location([0, 4], King.new(board, [0, 4], :black, [0, 4]))
        board.set_location([0, 3], Rook.new(board, [0, 3], :black, [0, 3]))
        board.set_location([3, 1], Pawn.new(board, [3, 1], :black, [3, 1]))
        board.set_location([6, 5], King.new(board, [6, 5], :white, [6, 5]))
        board.set_location([6, 4], Rook.new(board, [6, 4], :white, [6, 4]))
        board.set_location([3, 2], Pawn.new(board, [3, 2], :white, [3, 2]))
      end

      it 'returns black king' do
        board_render.render
        result = board.check
        expect(result).to eq board.instance_variable_get(:@black_king)
      end
    end
    context 'when enemy is not in check' do

      before do
        board.set_location([0, 4], King.new(board, [0, 4], :black, [0, 4]))
        board.set_location([0, 3], Rook.new(board, [0, 3], :black, [0, 3]))
        board.set_location([3, 1], Pawn.new(board, [3, 1], :black, [3, 1]))
        board.set_location([6, 5], King.new(board, [6, 5], :white, [6, 5]))
        board.set_location([6, 3], Rook.new(board, [6, 3], :white, [6, 3]))
        board.set_location([3, 2], Pawn.new(board, [3, 2], :white, [3, 2]))

      end

      it 'returns nil' do
        board_render.render
        result = board.check
        expect(result).to be nil
      end
    end
  end

  describe '#checkmate?' do

    context 'when a king is in checkmate' do

      before do
        board.set_location([0, 0], King.new(board, [0, 0], :black, [0, 0]))
        board.set_location([6, 5], King.new(board, [6, 5], :white, [6, 5]))
        board.set_location([1, 2], Rook.new(board, [1, 2], :white, [1, 2]))
        board.set_location([3, 1], Rook.new(board, [3, 1], :white, [3, 1]))
        board.set_location([7, 0], Queen.new(board, [0, 7], :white, [7, 0]))

      end

      it 'returns black king' do
        board_render.render
        result = board.checkmate
        expect(result).to be board.instance_variable_get(:@black_king)
      end
    end

    context 'when a king is in check but not checkmate' do

      before do
        board.set_location([0, 0], King.new(board, [0, 0], :black, [0, 0]))
        board.set_location([6, 5], King.new(board, [6, 5], :white, [6, 5]))
        board.set_location([1, 2], Rook.new(board, [1, 2], :white, [1, 2]))
        board.set_location([7, 0], Queen.new(board, [0, 7], :white, [7, 0]))
      end

      it 'returns nil' do
        board_render.render
        result = board.checkmate
        expect(result).to be nil
      end
    end
  end


end
