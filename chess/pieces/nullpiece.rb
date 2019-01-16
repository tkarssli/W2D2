require_relative "piece"
require "singleton" 

class NullPiece < Piece
    include Singleton
    def initialize(_color= :empty,_board = nil, _name = " ", _pos = nil)
        super(_color,_board, _name, _pos)
    end
end