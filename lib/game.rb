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
        player = current_player
        puts "Where would you like to move? Please enter 1-9."
        current_move = player.move(@board)
        if !@board.valid_move?(current_move)
            puts "That's an invalid move!"
            turn
        else
            puts "Moving to space #{current_move}"
            @board.update(current_move, player)
            @board.display
        end
    end

    def play
        until over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end


end