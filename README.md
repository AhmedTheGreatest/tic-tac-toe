# Tic Tac Toe
A simple Tic Tac Toe game made implemented in Ruby for TheOdinProject.
  
## Usage

To play the game, run `$ ruby tictactoe.rb` in your terminal

For info on how to play the game visit [Wikipedia](https://en.wikipedia.org/wiki/Tic-tac-toe)

## Code Overview

The game contains the following classes:

- `Board`: Represents the 3x3 tic tac toe board. Handles displaying, updating, and checking state of the board.
- `Player`: Represents a player, with a name and symbol (X or O). Has a method to get moves from player.

- `Game`: Manages the overall game flow and logic. Handles switching players, checking for winner or tie, etc.

- The `TicTacToe` module contains and ties together the other classes.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.