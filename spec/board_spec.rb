require_relative '../main'

describe Board do

  subject(:board) { described_class.new }
  let(:board_render) {  BoardRender.new(board) }

  describe '#check?' do

    context 'when enemy is in check' do

      before do
        board.set_location([0, 4], King.new(board, [0, 4], :black, [0, 4]))
        board.set_location([0, 3], Rook.new(board, [0, 3], :black, [0, 3]))
        board.set_location([6, 5], King.new(board, [6, 5], :white, [6, 5]))
        board.set_location([6, 4], Rook.new(board, [6, 4], :white, [6, 4]))
      end

      it 'returns true' do
        board_render.render
        result = board.check?
        expect(result).to be true
      end
    end
    context 'when enemy is not in check' do

      before do
        board.set_location([0, 4], King.new(board, [0, 4], :black, [0, 4]))
        board.set_location([0, 3], Rook.new(board, [0, 3], :black, [0, 3]))
        board.set_location([6, 5], King.new(board, [6, 5], :white, [6, 5]))
        board.set_location([6, 3], Rook.new(board, [6, 3], :white, [6, 3]))

      end

      it 'returns false' do
        board_render.render
        result = board.check?
        expect(result).to be false
      end
    end 
  end


end
