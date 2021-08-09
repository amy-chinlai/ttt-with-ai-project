module Players

    class Computer < Player

        def move(board)
            if board.turn_count == 0
                "1"
            elsif board.turn_count == 1
                if !board.taken?(5)
                    "5" 
                else
                    "7"
                end
            elsif board.turn_count == 2
                ["1", "3", "7", "9"].detect {|spot| !board.taken?(spot)}
            elsif board.turn_count == 3
                if board.cells[6] != " "
                    "7"
                else
                    "3"
                end
            elsif board.turn_count == 4
                ["1", "3", "7", "9"].detect {|spot| !board.taken?(spot)}
            elsif board.turn_count == 5
                ["1", "9"].detect {|spot| !board.taken?(spot)}
            elsif board.turn_count >= 6
                Game::WIN_COMBINATIONS.detect do |combo|
                    if combo.select{|i| board.position(i+1) == token}.size == 2 && combo.any?{|i| board.position(i+1) == " "}
                      combo.select{|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
                    elsif combo.select{|i| board.position(i+1) != " " && board.position(i+1) != token}.size == 2 && combo.any?{|i| board.position(i+1) == " "}
                      combo.select{|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
                    end
                end
            end
        end

    end


end