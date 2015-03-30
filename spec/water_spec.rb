require 'water'
describe Water do

  it 'can be hit' do
    expect(subject.hit).to eq "Miss"
  end

end