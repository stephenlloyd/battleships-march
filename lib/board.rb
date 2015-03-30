class Board
  DEFAULT_SIZE = 1
  DEFAULT_NUMBER_OF_PIECES = 1

  attr_reader :grid, :number_of_pieces

  def initialize options
    size = options.fetch(:size, DEFAULT_SIZE)
    cell = options.fetch(:cell)
    @number_of_pieces = options.fetch(:number_of_pieces, DEFAULT_NUMBER_OF_PIECES)
    @grid = create_grid(size, cell)
  end

  def create_grid size, cell
    letter_range_based_on_size(size).map do |letter|
      (1..dimension_size(size)).map do |number|
        {"#{letter}#{number}".to_sym => cell.new }
      end
    end.flatten.reduce(:merge)
  end

  def dimension_size size
    Math.sqrt(size).floor
  end

  def fill_all_content content
    grid.each{|k,v|v.content = content}
  end

  def letter_range_based_on_size size
    ("A"..to_letter_in_alphabet(dimension_size(size)))
  end

  def to_letter_in_alphabet number
    (number.ord + 64).chr
  end

  def place ship, coordinate, orientation = :horizontally
    raise "You can't place a ship outside the boundaries" unless coordinates_for(ship.size, coordinate, orientation).all? {|coordinate| coordinate_on_board?(coordinate)}
    coordinates_for(ship.size, coordinate, orientation).each do |coordinate|
      grid[coordinate].content = ship
    end
  end

  def coordinates_for size, coordinate, orientation
    coordinates = [coordinate]
    (size - 1).times {coordinates << next_coordinate(coordinates.last, orientation)}
    coordinates
  end

  def next_coordinate coordinate, orientation
    orientation == :horizontally ? coordinate.next : coordinate.to_s.reverse.next.reverse.to_sym
  end

  def coordinate_on_board? coordinate
    !grid[coordinate].nil?
  end

  def hit cell
    raise "Can't bomb a cell that doesn't exist" unless coordinate_on_board? cell
    grid[cell].content.hit
  end

  def all_ships_sunk?
    ships.all?(&:sunk?)
  end

  def ships
    grid.values.map(&:content).select{|content|content.respond_to? :sunk? }.uniq
  end

  def ready?
    ships.count == number_of_pieces
  end

  def lost?
    all_ships_sunk? && ready?
  end


end