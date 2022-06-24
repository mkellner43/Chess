require_relative '../main'

describe King do

  let(:board) { Board.new }
  let(:board_render) {  BoardRender.new(board) }

  describe '#get_rooks_castling' do

    context 'when there are 2 rooks available for castling' do

      before do
        board.set_location([0, 7], Rook.new(board, [0, 7], :white, [0, 7]))
        board.set_location([0, 0], Rook.new(board, [0, 0], :white, [0, 0]))
        board.set_location([0, 4], King.new(board, [0, 4], :white, [0, 4]))
      end

      it 'returns 2 rook objects' do
        board_render.render
        king = board.get_piece([0, 4])
        rook2 = board.get_piece([0, 7])
        rook = board.get_piece([0, 0])
        result = king.get_rooks_castling
        expect(result).to eq [rook, rook2]
      end
    end
  

    context 'when there is 1 rook available for castling' do

      before do
        board.set_location([0, 7], Rook.new(board, [0, 7], :white, [0, 7]))
        board.set_location([0, 0], Rook.new(board, [0, 0], :white, [0, 1]))
        board.set_location([0, 4], King.new(board, [0, 4], :white, [0, 4]))
      end

      it 'returns 1 rook' do
        board_render.render
        king = board.get_piece([0, 4])
        rook = board.get_piece([0, 7])
        rook2 = board.get_piece([0, 0])
        result = king.get_rooks_castling
        expect(result).to eq [rook]
      end
    end

    context 'when there are no rooks available for castling' do
      before do
        board.set_location([0, 7], Rook.new(board, [0, 7], :white, [0, 7]))
        board.set_location([0, 0], Rook.new(board, [0, 0], :white, [0, 1]))
        board.set_location([0, 4], King.new(board, [0, 4], :white, [0, 3]))
      end

      it 'returns 0 rooks' do
        board_render.render
        king = board.get_piece([0, 4])
        rook = board.get_piece([0, 7])
        rook2 = board.get_piece([0, 0])
        result = king.get_rooks_castling
        expect(result).to eq []
      end
    end
  end

  describe '#row_available_castling' do

    context 'when row is available for castling' do

      before do
        board.set_location([0, 7], Rook.new(board, [0, 7], :white, [0, 7]))
        board.set_location([0, 0], Rook.new(board, [0, 0], :white, [0, 0]))
        board.set_location([0, 4], King.new(board, [0, 4], :white, [0, 4]))
      end

      it 'returns true' do
        board_render.render
        king = board.get_piece([0, 4])
        rook = board.get_piece([0, 7])
        result = king.row_available_castling(rook)
        expect(result).to be true
      end
    end
  end

  # describe '#castling' do

  #   context 'when castling is available and both rooks are in game' do

  #     before do
  #       board.set_location([0, 7], Rook.new(board, [0, 7], :white, [0, 7]))
  #       board.set_location([0, 0], Rook.new(board, [0, 0], :white, [0, 0]))
  #       board.set_location([0, 4], King.new(board, [0, 4], :white, [0, 3]))
  #     end

  #     it 'returns positions' do
  #       board_render.render
  #       king = board.get_piece([0, 4])
  #       rook = board.get_piece([0, 7])
  #       rook2 = board.get_piece([0, 0])
  #       result = king.castling
  #       expect(result).to eq rook
  #     end
  #   end
  # end

end