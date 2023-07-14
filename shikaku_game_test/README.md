# minigames

## Game Menu
ChatGPT
Prompt:
- Use flutter to develop a game. First page is a menu of a list of game. First game in the menu is tic tac toe for 2 players.

## Tictactoe
ChatGPT
Prompt:
- you are a flutter developer. write a tic tac toe game in a page for 2 players. check for a winner or a draw. add a float button to restart the game

## Tictactoe in 4x4 grid for 3 players
GPT3.5 turbo
Prompts:
- You are a flutter developer. Write a 4x4 tic tac toe game for 3 players
- Add a function to check for winner or draw from board
- win condition change. 3 tiles linked win.
- write unit tests for _checkForWinnerOrDraw[^1]

## Shikaku
GPT3.5 turbo
Prompts:
- you are a flutter developer, write a game of Shikaku[^2]
- write a line of code to log selectcell
- use logging framework
- create a variable, which is a list of color
- cell color is linked with list grid[^2][^3]
- create a function, check if the selected area is valid on conditions. condition 1, only one positive integer in variable numbers. condition 2, area match the integer[^4]
- dart math return abs value
- add a reset float button to fill grid with 0
- create a function to check all value in grid is larger than 0. show a win game dialog[^2][^4]

## Shikaku game board generator
GPT3.5 turbo
Prompts:
- you are a flutter developer, write a function to generate a list for shikaku game.
  default size is 5x5.
  the function does not need input for number of rectangle.
  minimal rectangle area must be 2.
  rectangles must not overlap each other.
  try to generate another rectangle if it cannot find a unoccupied space for the rectangle after trying 5 times.
  after retries, check if any empty cell.
- write a function to check smallest rectangle area. the input is a populated int array. in the array, each rectangle is represent by a number. 0 represent empty space.
- write a function to convert the list array from rectangle index into 0. place a rectangle area value into a random space within the rectangle
- place a rectangle area value into a random space within the rectangle instead of filling value.


## Whack a mole
GPT3.5 turbo
Prompt:
- as a flutter developer, code a whack a mole game with 1 player and 10 holes for hamsters to pop out
- do not use flame
- Vertical viewport was given unbounded height.
- the hamster should randomly visible, and can be whack when it is visible
- Non-nullable instance field '_timer' must be initialized.
- _isVisibleList is not defined in HamsterHole

## Scrum sizing card
GPT3.5 turbo
Prompt:
- you are a flutter developer. Write a app page for scrum sizing

## Chess (WIP)
GPT3.5 turbo
Prompt:
- write a flutter app for chess board with chess pieces. player can take turn to move the chess

## Go Chess (WIP)
GPT3.5 turbo
Prompt:
- you are a flutter developer, write a page with a 9x9 go chess board. players can take turn a play. check if the chess can be played. remove dead chess piece. show no. of dead chess piece. calculate score after each move.
- you are a dart developer. develop a strategy to check if a go chess piece should be remove from a go chess board.

# Roll Dice
GPT3.5 turbo
Prompt:
- You are a flutter developer. You write code that follows SOLID and DRY principles. Write a page to throw 3 dice with random result display. Display the sum. Display message if double or triple. The message also describe the roll of double and triple. Write unit tests to test the logic that determinate double and triple but not test the message output. the unit test coverts every edge cases.

## Flappy Bird (WIP)
Prompt:
- create a flappy bird game in flutter. focus on the background scrolling. background scroll from right to left slowly, and then repeat.
Image download from https://weeklyhow.com/flappy-bird-unity-tutorial/

[^1]: The unit test ignore the 3 tiles link rule.
[^2]: reference to -1 in array
[^3]: need to fix binding logic
[^4]: refactored

## Setup
https://firebase.google.com/docs/flutter/setup?platform=ios