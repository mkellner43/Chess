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

  describe '#wants_to_castle?' do
    let(:king) { King.new(board, [0, 3], :white, [0, 3]) }
    let(:rook) { Rook.new(board, [0, 7], :white, [0, 7]) }
    let(:rook2) { Rook.new(board, [0, 0], :white, [0, 0]) }
    
    context 'when player responds y' do

      it 'returns true' do
        allow(king).to receive(:gets).and_return('y')
        result = king.wants_to_castle?
        expect(result).to eq true
      end
    end

    context 'when player responds n' do

      it 'returns false' do
      allow(king).to receive(:gets).and_return('n')
      result = king.wants_to_castle?
      expect(result).to be false
      end
    end
  end

  describe '#valid_rook' do
    let(:king) { King.new(board, [0, 4], :white, [0, 4]) }
    let(:rook) { Rook.new(board, [0, 7], :white, [0, 7]) }
    let(:rook2) { Rook.new(board, [0, 0], :white, [0, 0]) }

    context 'when player selects a valid rook' do

      before do
        board.set_location([0, 7], rook)
        board.set_location([0, 0], rook2)
        board.set_location([0, 4], king)
      end

      it 'returns selected rook' do
        allow(king).to receive(:puts)
        selected_rook = '8a'
        allow(king).to receive(:gets).and_return(selected_rook)
        result = king.valid_rook([rook2])
        expect(result).to eq rook2
      end
    end
  end

  describe '#make_castling_move' do
    let(:king) { King.new(board, [0, 4], :white, [0, 4]) }
    let(:rook) { Rook.new(board, [0, 7], :white, [0, 7]) }
    let(:rook2) { Rook.new(board, [0, 0], :white, [0, 0]) }

    context 'moves rook and king to proper castling location' do

      before do
        board.set_location([0, 7], rook)
        board.set_location([0, 0], rook2)
        board.set_location([0, 4], king)
      end

      it 'returns nested array [[0, 3], [0, 2]]' do
        answer = [[0, 3], [0, 2]]
        result = king.make_castling_move(rook2)
        expect(result).to eq answer
      end

      it 'returns nested array [[0, 5],[0, 6]]' do
        answer = [[0, 5], [0, 6]]
        result = king.make_castling_move(rook)
        expect(result).to eq answer
      end
    end
  end

  describe '#castling' do
    let(:king) { King.new(board, [0, 3], :white, [0, 3]) }
    let(:rook) { Rook.new(board, [0, 7], :white, [0, 7]) }
    let(:rook2) { Rook.new(board, [0, 0], :white, [0, 0]) }
    context 'when left rook is selected' do

      before do
        board.set_location([0, 7], rook)
        board.set_location([0, 0], rook2)
        board.set_location([0, 3], king)
      end

      it 'correctly castles towards left rook' do
        allow(king).to receive(:gets).and_return('y', '8a')
        result = king.castling
        expect(result).to be true
        board_render.render
      end
    end
  end

  describe '#wouldnt_put_self_in_check' do

    let(:king) { King.new(board, [0, 0], :white, [0, 0]) }
    let(:king2) { King.new(board, [7, 4], :black, [7, 4]) }
    let(:rook) { Rook.new(board, [0, 3], :white, [0, 3]) }
    let(:rook2) { Rook.new(board, [1, 0], :white, [1, 0]) }

    context 'if move would put self in check' do
      

      before do
        board.set_location([0, 0], king)
        board.set_location([6, 5], king2)
        board.set_location([0, 3], rook)
        board.set_location([1, 0], rook2)
        board.set_location([7, 0], Queen.new(board, [0, 7], :black, [7, 0]))
      end

      it 'returns false' do
        board_render.render
        possible_location = [1, 1]
        result = rook2.wouldnt_put_self_in_check(possible_location)
        expect(result).to be false
      end
    end

    context 'if move would not put self in check' do

      before do
        board.set_location([0, 0], king)
        board.set_location([6, 5], king2)
        board.set_location([0, 3], rook)
        board.set_location([1, 0], rook2)
        board.set_location([7, 0], Queen.new(board, [0, 7], :black, [7, 0]))
      end

      it 'returns true' do
        board_render.render
        possible_location = [0, 1]
        result = rook.wouldnt_put_self_in_check(possible_location)
        expect(result).to be true
      end
    end
  end
end