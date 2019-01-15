Dir["pieces/*.rb"].each {|file| require_relative file }
require "byebug"

class Board
    attr_accessor :grid 
    def initialize
        @grid = Array.new(8){|el| el = Array.new(8)}
        set_up_board 
    end

    def set_up_board
        black_pieces = [
            Rook.new(:black, "R_b"),
            Knight.new(:black, "N_b"),
            Bishop.new(:black, "B_b"),
            King.new(:black, "K_b"),
            Queen.new(:black, "Q_b"),
            Bishop.new(:black, "B_b"),
            Knight.new(:black, "N_b"),
             Rook.new(:black, "R_b")
        ]
        white_pieces = [
            Rook.new(:white, "R_w"),
            Knight.new(:white, "N_w"),
            Bishop.new(:white, "B_w"),
            Queen.new(:white, "Q_w"),
             King.new(:white, "K_w"),
            Bishop.new(:white, "B_w"),
            Knight.new(:white, "N_w"),
             Rook.new(:white, "R_w")
        ]
        grid.map!.with_index do |row, row_num|
            case row_num
            when 0
                black_pieces 
            when 1 
                Array.new(8){|el| el = Pawn.new(:black, "p_b")}
            when 6
                Array.new(8){|el| el = Pawn.new(:white, "p_w")}
            when 7
                white_pieces
            else   
                Array.new(8){|el| el = NullPiece.instance}
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

        def move_piece(color, start_pos, end_pos)
            debugger
            raise "No piece at position" if self[start_pos] == NullPiece.instance
            raise "No friendly fire!" if self[end_pos].color == color
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
end