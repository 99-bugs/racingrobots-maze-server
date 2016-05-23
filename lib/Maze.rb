require "./lib/Wall"

class Maze

    SCALE = 2440 / 12
    attr_reader :walls

    def initialize
        @walls = Array.new
        @walls_prepare = Array.new

        @walls_prepare.push(
            Wall[[0,0],[12,0]],
            Wall[[12,0],[12,6]],
            Wall[[12,6],[0,6]],
            Wall[[0,6],[0,0]],

            Wall[[0,1],[2,1]],
            Wall[[2,1],[2,2]],
            Wall[[2,2],[4,2]],
            Wall[[4,2],[4,1]],
            Wall[[4,1],[3,1]],

            Wall[[0,4],[1,4]],
            Wall[[1,4],[1,2]],

            Wall[[1,6],[1,5]],
            Wall[[1,5],[3,5]],

            Wall[[4,6],[4,3]],
            Wall[[5,1],[5,3]],
            Wall[[5,3],[3,3]],
            Wall[[3,3],[3,4]],
            Wall[[3,4],[2,4]],
            Wall[[2,4],[2,3]],

            Wall[[5,6],[5,5]],
            Wall[[5,5],[7,5]],

            Wall[[8,6],[8,4]],
            Wall[[8,4],[7,4]],

            Wall[[10,6],[10,4]],

            Wall[[10,2],[12,2]],

            Wall[[11,0],[11,1]],
            Wall[[11,1],[10,1]],

            Wall[[6,0],[6,2]],
            Wall[[6,2],[8,2]],
            Wall[[8,2],[8,1]],
            Wall[[8,1],[7,1]],

            Wall[[9,0],[9,5]],
            Wall[[11,5],[11,3]],
            Wall[[11,3],[6,3]],
            Wall[[6,3],[6,4]],
            Wall[[6,4],[5,4]]
        )

        @walls_prepare.each do |wall|
          x1 = wall.first.x * SCALE
          y1 = wall.first.y * SCALE
          x2 = wall.last.x * SCALE
          y2 = wall.last.y * SCALE
          @walls << Wall[[x1,y1],[x2,y2]]
        end
    end
end
