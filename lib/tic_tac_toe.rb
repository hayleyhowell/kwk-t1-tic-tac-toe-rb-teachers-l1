def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" 
      return combo 
    elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O" 
      return combo  
    end
  end 
  return false
end

def full?(board)
  board.each do |spot|
    if spot == " "
      return false 
    end
  end
  return true 
end

def draw?(board)
  if full?(board) && !won?(board)
    return true 
  else
    return false 
  end
end
  
def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true 
  else 
    return false
  end
end

def winner(board)
  winning_combo = won?(board)
  if winning_combo != false
    return board[winning_combo[0]]
  else 
    return nil 
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end 

def move(board, index, character)
  board[index] = character 
end

def valid_move?(board, index)
  if index.between?(0,8) && position_taken?(board,index) == false
    true
  else
    false
  end
end

def turn(board)
  character = current_player(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, character)
  else 
    until valid_move?(board, index)
      puts "Please enter 1-9:"
      input = gets
      index = input_to_index(input)
    end
    move(board, index, character)
  end
  display_board(board)
end

def turn_count(board)
  count = 0 
  board.each do |spot|
    if spot != " "
      count += 1 
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else 
    return "O"
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
end