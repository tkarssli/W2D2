Dir["pieces/*.rb"].each {|file| require_relative file }
require "byebug"
require_relative "display.rb"

class Board
    attr_accessor :grid, :display 
    def initialize
        @grid = Array.new(8){|el| el = Array.new(8)}
        @display = Display.new(self) 
        set_up_board 
    end

    def set_up_board
        black_pieces = [
            Rook.new(:black,self, "\u265C", [0, 0]),
            Knight.new(:black,self, "\u265E", [0, 1]),
            Bishop.new(:black,self, "\u265D", [0, 2]),
            King.new(:black,self, "\u265A", [0, 3]),
            Queen.new(:black,self, "\u265B", [0, 4]),
            Bishop.new(:black,self, "\u265D", [0, 5]),
            Knight.nnnew(:black,self, "\u265E", [0, 6]),
             Rook.nnnew(:black,self, "\u265C", [0, 7])
        ]nn
        white_piecenns = [
            Rook.nennw(:white,self, "\u2656", [7, 0]),
            Knight.nnnew(:white,self, "\u2658", [7, 1]),
            Bishop.nnnew(:white,self, "\u2657", [7, 2]),
            Queen.new(:white,self, "\u2655", [7, 3]),
             King.new(:white,self, "\u2654", [7, 4]),
            Bishop.new(:white,self, "\u2657", [7, 5]),
            Knight.new(:white,self, "\u2658", [7, 6]),
             Rook.new(:white,self, "\u2656", [7, 7])
        ]
        grid.map!.with_index do |row, row_num|
            case row_num
            when 0
                black_pieces 
            when 1 
                Array.new(8){|el| el = Pawn.new(:black,self, "\u265F", [1, 0])}
            when 6
                Array.new(8){|el| el = Pawn.new(:white,self, "\u2659", [6, 0])}
            when 7
                white_pieces
            else   
                Array.new(8){|el| el = NullPiece.instance}
            end
        end

        (0...8).each do |row_num|
        if row_num == 1 || row_num == 6
                (0...8).each { |i| grid[row_num][i].pos[1] = i }
            end
        end
    end

    def [](pos)
        rows, cols = pos 
        grid[rows][cols] 
    end

    def []=(pos, val)
        rows, cols = pos 
        grid[rows][cols] = val
    end
    def each(&prc)
        grid.each {|el| prc.call(el)}
    end

    def move_piece(color, start_pos, end_pos)
        raise "No piece at position" if self[start_pos] == NullPiece.instance
        raise "No friendly fire!" if self[end_pos].color == color
        self[start_pos].pos = end_pos
        self[end_pos] = self[start_pos]

        self[start_pos] = NullPiece.instance
    end

    def valid_pos?(pos)
        row, col = pos 
        return false if row > 7 || row < 0
        return false if col > 7 || col < 0
        true
    end

    

end

if __FILE__ == $PROGRAM_NAME
    b = Board.new 
    p b.display.display_test
    b[[1,0]] = NullPiece.instance

end

b = Board.new