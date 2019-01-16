require "colorize"
require_relative "cursor.rb"
require "byebug"


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
                    if cursor.selected
                        print " #{el.name} ".colorize(:background => :light_green)
                    else
                        print " #{el.name} ".colorize(:background => :light_red)
                    end
                else
                    if (i+j).even?
                        print " #{el.name} ".on_white
                    else
                        print " #{el.name} ".on_red
                    end
                end
            end
        puts
        end
    end
end