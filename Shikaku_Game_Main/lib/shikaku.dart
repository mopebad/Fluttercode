import 'dart:math';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class ShikakuGame extends StatefulWidget {
  final List<int> numbers;

  const ShikakuGame({Key? key, required this.numbers}) : super(key: key);

   @override
  ShikakuGameState createState() => ShikakuGameState();
}

class ShikakuGameState extends State<ShikakuGame> {
  late List<List<int>> grid;
  int? selectedRow;
  int? selectedCol;
  final _logger = Logger('ShikakuGame');
  int colorIndex = 0;
  final List<Color> colors = [
    Colors.black38,
    Colors.deepOrange.shade300,
    Colors.lightGreen.shade300,
    Colors.blueGrey.shade300,
    Colors.amber.shade300,
    Colors.orange.shade300,
    Colors.pink.shade300,
    Colors.deepPurple.shade300,
    Colors.teal.shade300,
    Colors.brown.shade300,
    Colors.indigo.shade300,
    Colors.cyan.shade300,
    Colors.red.shade300,
    Colors.green.shade300,
    Colors.purple.shade300,
    Colors.yellow.shade300,
    Colors.blue.shade300,
    Colors.lime.shade300,
    Colors.lightBlue.shade300,
  ];

  @override
  void initState() {
    super.initState();
    grid = List.generate(7, (row) => List.generate(7, (col) => 0));
  }

  

  

  bool checkWin() {
    for (int row = 0; row < 7; row++) {
      for (int col = 0; col < 7; col++) {
        if (grid[row][col] == 0) {
          return false;
        }
      }
    }
    return true;
  }
  
  void showWinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: const Text('You have solved the puzzle.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  void selectCell(int row, int col) {
    _logger.info('Selected cell at row $row, column $col');
    
    setState(() {
      if (selectedRow != null && (selectedRow != row || selectedCol != col)) {
        // User has selected a second cell
        int area = selectedArea(row, col, selectedRow!, selectedCol!);
        _logger.info('Selected area $area');

        if (isValidSelection(row, col, selectedRow!, selectedCol!)) {
          // User has selected a valid area
          _logger.info('Valid selection');
          colorSelection(row, col, selectedRow!, selectedCol!);
        }

        if (checkWin()) {
          showWinDialog();
        }

        selectedRow = null;
        selectedCol = null;
      } else {
        // User has selected a cell for the first time
        selectedRow = row;
        selectedCol = col;
      }
    });
  }

  List<int> moveHistory = [];

  void undoMove() {
    setState(() {
      if (moveHistory.isNotEmpty) {
        int lastColorIndex = moveHistory.removeLast();
        for (int row = 0; row < 7; row++) {
          for (int col = 0; col < 7; col++) {
            if (grid[row][col] == lastColorIndex) {
              grid[row][col] = 0;
            }
          }
        }
      }
    });
  }

  void colorSelection(int row1, int col1, int row2, int col2) {
    colorIndex++;
    if (colorIndex > colors.length - 1) {
      colorIndex = 1;
    }
    for (int r = min(row1, row2); r <= max(row1, row2); r++) {
      for (int c = min(col1, col2); c <= max(col1, col2); c++) {
        grid[r][c] = colorIndex;
      }
    }
    moveHistory.add(colorIndex);
  }

  int selectedArea(int row1, int col1, int row2, int col2) {
    return ((row2 - row1).abs() + 1) * ((col2 - col1).abs() + 1);
  }

  bool isValidSelection(int row1, int col1, int row2, int col2) {
  int selectedNumber = -1;
  int startRow = min(row1, row2);
  int endRow = max(row1, row2);
  int startCol = min(col1, col2);
  int endCol = max(col1, col2);

  for (int row = startRow; row <= endRow; row++) {
    for (int col = startCol; col <= endCol; col++) {
      int number = widget.numbers[row * 7 + col];
      if (number > 0) {
        if (selectedNumber == -1) {
          selectedNumber = number;
        } else if (selectedNumber != number) {
          return false; // Condition 1 not met, more than 1 different positive integer selected
        }
      }
    }
  }

  if (selectedNumber == -1) {
    return false; // No positive integer selected
  }

  int selectedArea = (endRow - startRow + 1) * (endCol - startCol + 1);
  return selectedArea == selectedNumber;
}


  void resetGrid() {
    setState(() {
      for (int row = 0; row < 7; row++) {
        for (int col = 0; col < 7; col++) {
          grid[row][col] = 0;
        }
      }
    });
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
          'Daily Shikaku',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Divide the grid into rectangles and squares, such that each piece contains exactly one number, and that number equals the area of the piece.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Lato',
                //fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
    Expanded(
      child: Stack(
        children: [
          Center(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 7,
              itemBuilder: (context, row) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int col = 0; col < 7; col++)
                      GestureDetector(
                        onTap: () {
                          selectCell(row, col);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: const Border(
                              top: BorderSide(width: 4, color: Colors.white), // Outline top border
                              left: BorderSide(width: 4, color: Colors.white), // Outline left border
                              right: BorderSide(width: 4, color: Colors.white), // Outline right border
                              bottom: BorderSide(width: 4, color: Colors.white), // Outline bottom border
                            ),
                            color: colors[grid[row][col]],
                            // Update color of selected cell
                            boxShadow: selectedRow == row && selectedCol == col
                                ? [const BoxShadow(color: Colors.blue, blurRadius: 5)]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              '${widget.numbers[row * 7 + col]}',
                              style: const TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Positioned(
  bottom: 163.0,
  right: 535.0,
  child: Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 3.0),
    ),
    child: FloatingActionButton(
      onPressed: resetGrid,
      tooltip: 'Reset',
      backgroundColor: Colors.grey[800],
      child: const Icon(Icons.refresh, color: Colors.white),
    ),
  ),
),
Positioned(
  bottom: 90.0,
  right: 535.0, // Adjust the right value to position the Undo button
  child: Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 3.0),
    ),
    child: FloatingActionButton(
      onPressed: undoMove,
      tooltip: 'Undo',
      backgroundColor: Colors.grey[800],
      child: const Icon(Icons.undo, color: Colors.white),
    ),
  ),
),

        ],
      ),
    ),
  ],
),
    );
  }
}