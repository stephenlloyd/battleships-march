require 'game'
describe Game do
  let(:game){Game.new(player_1, player_2)}
  let(:player_1){double :player_1}
  let(:player_2){double :player_2}

  before do
    allow(player_2).to receive(:register_shot)
    allow(player_2).to receive(:lost?)
  end

  it "knows who player 1 is" do
    expect(game.player_1).to eq player_1
  end

  it "knows who player 2 is" do
    expect(game.player_2).to eq player_2
  end

  it "knows who's turn it is" do
    expect(game.turn).to eq player_1
  end

  it "switchs turns after each move" do
    game.make_move :A1
    expect(game.turn).to eq player_2
  end

  it "returns game over when the game is over" do
    expect(game).to receive(:over?).and_return true
    expect(game.make_move :A2).to eq "game over"
  end

  it "passes the shot to the opponent" do
    expect(player_2).to receive(:register_shot).with :A1
    game.make_move :A1
  end

  it "knows who the opponent is" do
    expect(game.opponent).to eq player_2
  end

  it "knows when the game is over" do
    expect(game).not_to be_over
  end

  it "asks the player if they've lost" do
    expect(player_2).to receive(:lost?)
    game.make_move :A1
  end

  it "knows if the game is ready" do
    allow(player_1).to receive(:ready?).and_return true
    allow(player_2).to receive(:ready?).and_return true
    expect(game.ready?).to eq true
  end

  it "knows a game is not ready when player 1 isn't ready" do
    allow(player_1).to receive(:ready?).and_return false
    allow(player_2).to receive(:ready?).and_return true
    expect(game.ready?).to eq false
  end

  it "knows a game is not ready when player 2 isn't ready" do
    allow(player_1).to receive(:ready?).and_return true
    allow(player_2).to receive(:ready?).and_return false
    expect(game.ready?).to eq false
  end



end