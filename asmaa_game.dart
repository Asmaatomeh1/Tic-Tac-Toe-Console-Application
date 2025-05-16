import 'dart:io';

// Represents the Tic-Tac-Toe game board with 9 positions.
List<String> board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

// Displays the current state of the game board.
void printBoard() {
  print('\nBoard:\n');
  print(' ${board[0]} | ${board[1]} | ${board[2]} ');
  print('---+---+---');
  print(' ${board[3]} | ${board[4]} | ${board[5]} ');
  print('---+---+---');
  print(' ${board[6]} | ${board[7]} | ${board[8]} ');
}

// Checks if the specified player has met any of the winning conditions.
bool checkWinner(String player) {
  List<List<int>> winConditions = [
    [0, 1, 2], // Rows
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6], // Columns
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8], // Diagonals
    [2, 4, 6],
  ];

  for (var condition in winConditions) {
    if (board[condition[0]] == player &&
        board[condition[1]] == player &&
        board[condition[2]] == player) {
      return true;
    }
  }
  return false;
}

// Checks if the board is completely filled without any empty spots.
bool isFull() {
  for (var cell in board) {
    if (cell != 'X' && cell != 'O') {
      return false;
    }
  }
  return true;
}

// Main game loop for a single round of Tic-Tac-Toe.
void play() {
  // Reset the board at the start of each new game
  board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  String currentPlayer = 'X';

  while (true) {
    printBoard();
    print("\n Player $currentPlayer's turn. ");
    print('Enter a Number ( 1 - 9 ) : ');
    int? num = int.tryParse(stdin.readLineSync()!);

    // Validate input
    if (num == null ||
        num < 1 ||
        num > 9 ||
        board[num - 1] == 'X' ||
        board[num - 1] == 'O') {
      print('❌ Invalid move. Try again.\n');
      continue;
    }

    // Make the move
    board[num - 1] = currentPlayer;

    // Check for win
    if (checkWinner(currentPlayer)) {
      printBoard();
      print('\n🎉 Player $currentPlayer wins!');
      break;
    }

    // Check for draw
    if (isFull()) {
      printBoard();
      print('\n🤝 It\'s a draw!');
      break;
    }

    // Switch player
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }
}

// Entry point of the application.
void main() {
  print('=== Welcome to Tic-Tac-Toe ===\n');

  while (true) {
    play();

    // Ask to restart
    stdout.write('\n🔁 Do You Want To Play Again? (y/n): ');
    String? answer = stdin.readLineSync();

    if (answer == null || answer.toLowerCase() != 'y') {
      print('\n👋 Thanks for playing!');
      break;
    }
  }
}
