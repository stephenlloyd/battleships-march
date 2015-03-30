class Player

  attr_reader :name
  attr_accessor :board

  def initialize name
    @name = name
  end

  def has_board?
    !board.nil?
  end

  def ready?
    has_board? && board.ready?
  end

  def lost?
    ready? && board.lost?
  end

  def register_shot cell
    board.hit cell
  end

end