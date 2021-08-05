class Game

    attr_accessor :board, :player_1, :player_2
    
    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [6, 4, 2]
    ]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @board = board
        @player_1 = player_1
        @player_2 = player_2
    end

    def current_player
        if @board.turn_count.even?
            player_1
        else
            player_2
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |winner|
            @board.cells[winner[0]] == @board.cells[winner[1]] && 
            @board.cells[winner[1]] == @board.cells[winner[2]] &&
            (@board.cells[winner[0]] == "X" || @board.cells[winner[0]] == "O")
        end
    end

    def draw?
        @board.full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        @winner = @board.cells[won?.first] if won?
        @winner
    end

    def turn
        puts "Where would you like to move?"
        input = gets.strip
        # index = input_to_index(input)
        # if valid_move?(index)
        #     move(index, token = current_player)
        #     display_board
        # else
        #     turn
        # end
    end


end