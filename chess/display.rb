require "colorize"
require_relative "cursor.rb"


class Display
    attr_reader :board, :cursor
    def initialize(board)
        @cursor = Cursor.new([0, 0], board)
        @board = board 
    end

    def display_test
        while true
            system "clear" 
            render 
            cursor.get_input
        end
    end

    def render
        cp= cursor.cursor_pos
        board.grid.each.with_index do |row, i|
            row.each_with_index  do |el, j|
                if cp == [i,j]
                    print " #{el.name} ".colorize(:background => :light_red)
                else
                print " #{el.name} "
                end
            end
        puts
        end
    end
end