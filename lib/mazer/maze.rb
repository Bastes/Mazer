require 'mazer/cell'

module Mazer
  # =The Maze
  #
  # The Maze::Maze class holds a maze.
  #
  # (see the readme for exemples)
  class Maze

    # Raw array of raw cells.
    attr_reader :cells

    # Create's new maze's instance.
    #
    # To build a square maze, let the height be nil.
    def initialize width, height = nil
      height ||= width
      @cells = Array.new(width) { |y| Array.new(height) { |x| 0 } }
    end

    # Accesses a cell by its coordinates (or nil when coordinates are outside the maze).
    def [] x, y
      Cell.new(self, x, y) if y >= 0 and x >= 0 and y < height and x < width
    end

    # Width of the maze.
    def width
      @cells[0].length
    end

    # Height of the maze.
    def height
      @cells.length
    end

    # Iterates on each cells of the maze, line by line, from left to right.
    def each # :yields: cell
      width.times { |y| height.times { |x| yield Cell.new(self, x, y) } }
    end
  end
end
