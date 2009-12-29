module Mazer
  # =Maze Cells
  #
  # Cells are generated on the fly to provide wrappers accessing raw maze data in a more user-friendly way.
  #
  # (see the README for examples)
  #
  # Convenience methods are added for direction-related methods, for example :
  # cell.north::      => cell.relative :north
  # cell.door_south:: => cell.door :south
  # cell.open_east::  => cell.open :east
  # cell.close_west:: => cell.close :west
  class Cell
    # Conversions from direction symbol to binary direction.
    CONVERSION = { :north => 1, :west => 2, :south => 4, :east => 8 }
    # Directions expressed in coordinate vectors.
    DIRECTIONS = { :north => [0, -1], :west => [-1, 0], :south => [0, 1], :east => [1, 0] }
    # Directions opposed.
    OPPOSITION = { :north => :south, :west => :east, :south => :north, :east => :west }

    # Cell's coordinates.
    attr_reader :x, :y
    # Cell's maze.
    attr_reader :maze

    def initialize maze, x, y # :nodoc:
      @maze = maze
      @x = x
      @y = y
    end

    # Access the cell's direct neighbour in specified direction.
    def relative direction
      x, y = DIRECTIONS[direction]
      @maze[@x + x, @y + y]
    end

    # Access the cell through specified door if there is such door.
    def door direction
      movement = DIRECTIONS[direction]
      ((bin & CONVERSION[direction]) > 0) and (@maze[@x + movement.first, @y + movement.last] or true)
    end

    # Access the list of this cell's door (as an array of symboles).
    def doors
      CONVERSION.collect { |d, b| ((bin & b) > 0) ? d : nil }.compact
    end

    # Opens the door in specified direction.
    #
    # Returns the opened door's cell or true when opening on the border.
    def open direction
      if not door(direction)
        self.bin = bin | CONVERSION[direction]
        other_cell = relative(direction)
        other_cell.open OPPOSITION[direction] if other_cell
        other_cell or true
      end
    end

    # Closes the door in specified direction.
    def close direction
      if door(direction)
        self.bin = bin - (bin & CONVERSION[direction])
        other_cell = relative(direction)
        other_cell.close OPPOSITION[direction] if other_cell
        nil
      end
    end

    def == other
      other.maze == @maze and other.x == @x and other.y == @y
    end

    DIRECTIONS.each do |direction, movement|
      self.instance_eval do
        define_method direction do
          relative direction
        end
        
        define_method "door_#{direction}" do
          door direction
        end

        define_method "open_#{direction}" do
          open direction
        end

        define_method "close_#{direction}" do
          close direction
        end
      end
    end

    private

    def bin
      @maze.cells[@y][@x]
    end

    def bin= value
      @maze.cells[@y][@x] = value
    end
  end
end
