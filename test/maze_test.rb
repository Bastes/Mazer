require 'test/helper'

class MazeTest < Test::Unit::TestCase
  context "A freshly created 10x10 cell maze" do
    setup { @maze = Maze::Maze.new 10 }

    should "be 10x10" do
      assert_equal @maze.width, 10
      assert_equal @maze.height, 10
    end

    should "have 100 closed cells" do
      counter = 0
      @maze.each { |cell| counter += 1; assert_equal cell.doors, [] }
      assert_equal counter, 100
    end

    should "have the same cell extract counted as equal" do
      assert_equal @maze[1, 3], @maze[1,3]
    end

    should "have different cell extracts counted as different" do
      assert_not_equal @maze[3, 8], @maze[2,7]
    end

    context ", a single cell in the maze" do
      context "near the border" do
        context "in the north-west corner" do
          setup { @cell = @maze[0, 0] }

          should "have no neighbors towards the border" do
            assert_nil @cell.north
            assert_nil @cell.west
          end

          should "have neighbors towards the center" do
            assert_equal @cell.south, @maze[0, 1]
            assert_equal @cell.east, @maze[1, 0]
          end
        end
      end

      context "somwhere else" do
        setup { @cell = @maze[1,1] }

        should "know its neighbors" do
          assert_equal @cell.north, @maze[1, 0]
          assert_equal @cell.south, @maze[1, 2]
          assert_equal @cell.east, @maze[2, 1]
          assert_equal @cell.west, @maze[0, 1]
        end
      end
    end

    context ", when opening a door between 2 cells" do
      setup { @maze[1, 6].open :north }

      should "have the door opened both ways" do
        assert @maze[1, 6].door(:north) == @maze[1, 5]
        assert @maze[1, 5].door(:south) == @maze[1, 6]
      end

      should "have opened only this door" do
        assert @maze[1, 6].doors == [:north]
        assert @maze[1, 5].doors == [:south]
      end
    end
  end
end
