require 'cell'

describe Cell do
  let(:cell){Cell.new}
  let(:ship){double :ship}

  it "can have content" do
    cell.content = ship
    expect(cell.content).to eq ship
  end

  context "cell with content" do
    before do
      cell.content = ship
      allow(ship).to receive(:hit)
    end

    it "can be hit" do
      cell.hit
      expect(cell).to be_hit
    end

    it "throws an error if you try to hit it twice" do
      cell.hit
      expect {cell.hit}.to raise_error "Cell already hit"
    end

    it "hits whatever is in the content" do
      expect(ship).to receive(:hit)
      cell.hit
    end
  end
end