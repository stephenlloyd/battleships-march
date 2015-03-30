require 'board'

describe Board do
  let(:cell){double :first_cell, content: ""}
  let(:second_cell){double :second_cell}
  let(:cell_class){double :cell_class, new: cell}
  let(:board){Board.new({size: 100, cell: cell_class, number_of_pieces: 5})}
  let(:ship){double :ship, size: 2, sunk?: false}
  let(:small_ship){double :ship, size: 1, sunk?: true}

  # TODO create lost? method

  it "has 100 cells in the grid" do
    expect(board.grid.count).to eq 100
  end

  it "can place a ship" do
    board.grid[:A1] = second_cell
    expect(second_cell).to receive(:content=).with small_ship
    board.place small_ship, :A1
  end

  it "knows the number of pieces required" do
    expect(board.number_of_pieces).to eq 5
  end

  it "can place a size 2 ship on the grid" do
    board.grid[:A1] = second_cell
    board.grid[:A2] = second_cell
    expect(second_cell).to receive(:content=).with(ship).exactly(2).times
    board.place ship, :A1
  end

  it "can work out the coordinatess for a size" do
    expect(board.coordinates_for(2, :A1, :horizontally)).to eq [:A1, :A2]
  end

  it "can place a size 2 ship on the grid vertically" do
    board.grid[:A1] = second_cell
    board.grid[:B1] = second_cell
    expect(second_cell).to receive(:content=).with(ship).exactly(2).times
    board.place ship, :A1, :vertically
  end

  it "knows if a coordinate is on the board" do
    expect(board.coordinate_on_board?(:A1)).to eq true
  end

  it "knows if a coordinate is not on the board" do
    expect(board.coordinate_on_board?(:A11)).to eq false
    expect(board.coordinate_on_board?(:K1)).to eq false
  end

  it "doesn't place a ship on the board if any part is outside the boundaries" do
    expect{board.place ship, :A10 }.to raise_error "You can't place a ship outside the boundaries"
  end

  it "can hit items on then board" do
    board.grid[:A1] = second_cell
    allow(second_cell).to receive(:content).and_return ship
    expect(ship).to receive(:hit)
    board.hit(:A1)
  end

  it "can't hit a cell outside of the boundaries" do
    expect {board.hit(:J11)}.to raise_error "Can't bomb a cell that doesn't exist"
  end

  it "knows if there are any floating ships" do
    board.grid[:A1] = second_cell
    allow(second_cell).to receive(:content).and_return ship
    expect(board.all_ships_sunk?).to eq false
  end

  it "knows that all ships are sunk" do
    board.grid[:A1] = second_cell
    allow(second_cell).to receive(:content).and_return small_ship
    expect(board.all_ships_sunk?).to eq true
  end

  it "knows what ships are on the board" do
    board.grid[:A1] = second_cell
    allow(second_cell).to receive(:content).and_return ship
    expect(board.ships).to eq [ship]
  end

  it "knows the board is not ready when 0 ships are on it" do
    expect(board).not_to be_ready
  end

  it "knows the board is  ready when required ship count ships are on it" do
    board = Board.new({cell: cell_class})
    allow(board).to receive(:ships).and_return [small_ship]
    expect(board).to be_ready
  end

  it "can fill all the content with water" do
    water = double :water
    expect(cell).to receive(:content=).with(water).exactly(100).times
    board.fill_all_content water
  end

  it "knows when it's lost and all ships have sunk" do
    allow(board).to receive(:ships).and_return [small_ship]
    allow(board).to receive(:ready?).and_return true
    expect(board.lost?).to eq true
  end


end