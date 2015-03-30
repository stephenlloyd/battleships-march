require 'player'
describe Player do
  let(:player){Player.new("Bob")}
  let(:board){double :board}

  it "can have a name" do
    expect(player.name).to eq "Bob"
  end

  it "can have a board" do
    player.board = board
    expect(player.board).to eq board
  end


  context "player with a board" do
    before { player.board = board }

    it "can know if it has a board" do
      expect(player).to have_board
    end

    it "knows if the board is ready" do
      expect(board).to receive(:ready?)
      player.ready?
    end

    context "and board is ready" do
      before {allow(board).to receive(:ready?).and_return true}

        it "knows if they have lost" do
          expect(board).to receive(:lost?)
          player.lost?
        end

        it "can register a shot" do
          expect(board).to receive(:hit).with :A1
          player.register_shot :A1
        end

    end


  end

end