
require 'byebug'
class Piece
    attr_accessor :pos 
    attr_reader :color, :name, :board 
    def initialize(color, board, name, pos)
        @color = color 
        @name = name 
        @pos = pos 
        @board = board 
    end
end

module SlidingPiece
    HORIZONTAL_DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    DIAGONAL_DIRS = [[1, 1], [-1, 1], [1, -1], [-1, -1]]

    def moves
        result = []
        moves_dirs.each do |dir|
            next_pos = [pos.first + dir.first, pos.last + dir.last]
            result += get_moves(dir, next_pos)
        end
        result.uniq.select {|el| el.length == 2} 
    end
    
    def get_moves(dir, new_pos) #[[1,0],[-1,0]] --> [[1,0]]
        #walls
        return [[]] if !board.valid_pos?(new_pos)
        #friendly
        return [[]] if board[new_pos].color == color 
        #enemies
        return [new_pos] if board[new_pos].color != color && board[new_pos].color != :empty
        old_pos = new_pos.dup
        new_pos[0] = new_pos.first + dir.first 
        new_pos[1] = new_pos.last + dir.last 
        [old_pos] + get_moves(dir, new_pos)
    end

    def moves_dirs
        return HORIZONTAL_DIRS if self.is_a?(Rook)
        return HORIZONTAL_DIRS + DIAGONAL_DIRS if self.is_a?(Queen)
        return DIAGONAL_DIRS if self.is_a?(Bishop)
    end
end

module SteppingPiece
    def moves
    end
end