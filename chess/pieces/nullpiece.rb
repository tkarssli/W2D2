require_relative "piece"
require "singleton" 

class NullPiece < Piece
    include Singleton
    def initialize(_color= :empty, _name = "x")
        super(_color, _name)
    end
end