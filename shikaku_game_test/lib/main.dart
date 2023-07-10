import 'dart:math';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class ShikakuGame extends StatefulWidget {
  final List<int> numbers;
  const ShikakuGame({Key? key, required this.numbers}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ShikakuGameState createState() => _ShikakuGameState();
}

class _ShikakuGameState extends State<ShikakuGame> {
  late List<List<int>> grid;
  late int rows;
  late int cols;
  int? selectedRow;
  int? selectedCol;
  final _logger = Logger('ShikakuGame');
  int colorIndex = 0;
  final List<Color> colors = [
    Colors.white70,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.amber,
    Colors.cyan,
    Colors.deepOrange,
    Colors.indigo,
    Colors.lime,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.deepPurple,
  ];

  @override
  void initState() {
    super.initState();
    rows = sqrt(widget.numbers.length).floor();
    cols = (widget.numbers.length / rows).ceil().toInt();
    grid = List.generate(rows, (row) => List.generate(cols, (col) => 0));
  }

  bool checkWin() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
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
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  void selectCell(int row, int col) {
    _logger.info('Selected cell at row $row, column $col');
    
    setState(() {
      if (selectedRow != null && ( selectedRow != row || selectedCol != col)) {
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
        int number = widget.numbers[row * cols + col];
        if (number > 0) {
          if (selectedNumber == -1) {
            selectedNumber = number;
          } else {
            return false; // Condition 1 not met, more than 1 positive integer selected
          }
        }
      }
    }
    if (selectedNumber == -1) {
      return false; // No positive integer selected
    }

    return (selectedArea(row1, col1, row2, col2) == selectedNumber); // Condition 2
  }

  void resetGrid() {
    setState(() {
      for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
          grid[row][col] = 0;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shikaku'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetGrid,
        tooltip: 'Reset',
        child: const Icon(Icons.refresh),
      ),      
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: rows,
          itemBuilder: (context, row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int col = 0; col < cols; col++)
                  GestureDetector(
                    onTap: () {
                      selectCell(row, col);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: colors[grid[row][col]],
                        // Update color of selected cell
                        boxShadow: selectedRow == row && selectedCol == col
                            ? [ const BoxShadow(color: Colors.blue, blurRadius: 5)]
                            : null,                        
                      ),
                      child: Center(
                        child: Text(
                          '${widget.numbers[row * cols + col]}',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
