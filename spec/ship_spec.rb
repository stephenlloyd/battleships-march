require 'ship'

describe Ship do
  let(:ship){Ship.new({size: 2})}

  it "can have a size" do
    expect(ship.size).to eq 2
  end

  it "can not be sunk" do
    expect(ship).not_to be_sunk
  end

  it "can be sunk" do
    ship.hit
    ship.hit
    expect(ship).to be_sunk
  end

  it "can intialize a battleship" do
    battleship = Ship.battleship
    expect(battleship.size).to eq 4
  end

end