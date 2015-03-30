class Game

  attr_reader :player_1, :player_2, :turn

  def initialize player_1, player_2
    @player_1, @player_2, @turn = player_1, player_2, player_1
  end

  def make_move position
    opponent.register_shot position
    return "game over" if over?
    switch_turns
  end

  def opponent
    turn == player_1 ? player_2 : player_1
  end

  def over?
    opponent.lost?
  end

  def ready?
    player_1.ready? && player_2.ready?
  end

  private

  def switch_turns
    @turn = opponent
  end

end