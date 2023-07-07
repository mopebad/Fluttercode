import 'package:flutter/material.dart';

void main() {
  runApp(ShikakuGame());
}

class ShikakuGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shikaku Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShikakuGamePage(),
    );
  }
}

class ShikakuGamePage extends StatefulWidget {
  @override
  _ShikakuGamePageState createState() => _ShikakuGamePageState();
}

class _ShikakuGamePageState extends State<ShikakuGamePage> {
  late List<List<ShikakuCell>> cells;
  int numRows = 7;
  int numColumns = 7;
  int score = 0;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

 void resetGame() {
    setState(() {
      cells = List.generate(
        numRows,
        (_) => List.generate(
          numColumns,
          (_) => ShikakuCell(
            number: 0,
            filled: false,
          ),
        ),
      );
      cells[0][0].number = 3; // Set the number to 3 for the top left corner tile
      cells[0][numColumns - 1].number = 4; // Set the number to 4 for the top right corner tile
      cells[0][3].number = 3; // Sets the number to 3 for the center top tile
      cells[1][1].number = 4;
      cells[1][4].number = 4;
      cells[2][5].number = 6;
      cells[3][0].number = 2;
      cells[4][2].number = 4;
      cells[4][5].number = 4;
      cells[5][1].number = 6;
      cells[5][3].number = 2;
      cells[5][6].number = 3;
      cells[6][4].number = 4;
      
      

      score = 0;
    });
  }

  void toggleCellState(int row, int column) {
    setState(() {
      cells[row][column].filled = !cells[row][column].filled;
    });
  }

  void calculateScore() {
    int filledCells = 0;

    for (int row = 0; row < numRows; row++) {
      for (int column = 0; column < numColumns; column++) {
        if (cells[row][column].filled) {
          filledCells++;
        }
      }
    }

    setState(() {
      score = filledCells;
    });
  }

  void checkAndScoreRectangle(int row, int column) {
    if (cells[row][column].filled) return;

    int rectangleSize = 1;

    // Check right
    while (column + rectangleSize < numColumns &&
        cells[row][column + rectangleSize].filled) {
      rectangleSize++;
    }

    // Check down
    bool isRectangle = true;
    for (int i = 0; i < rectangleSize; i++) {
      if (row + i >= numRows || !cells[row + i][column].filled) {
        isRectangle = false;
        break;
      }
    }

    if (isRectangle) {
      setState(() {
        score += rectangleSize;
        for (int i = 0; i < rectangleSize; i++) {
          for (int j = 0; j < rectangleSize; j++) {
            cells[row + i][column + j].filled = true;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800], // Set a darker grey background color
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Shikaku Game',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Score: $score',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Align(
                alignment: Alignment.center, // Center the grid
                child: Container(
                  width: 700, // Set a fixed width
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 5.0,
                    ),
                  ),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: numColumns,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      final row = index ~/ numColumns;
                      final column = index % numColumns;

                      return GestureDetector(
                        onTap: () {
                          toggleCellState(row, column);
                          calculateScore();
                          checkAndScoreRectangle(row, column);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: cells[row][column].filled
                                ? Colors.grey[400] // Set a darker color for filled tiles
                                : Colors.grey[800], // Set a darker color for unfilled tiles
                          ),
                          child: Center(
                            child: cells[row][column].number > 0
                                ? Text(
                                    cells[row][column].number.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                    itemCount: numRows * numColumns,
                    shrinkWrap: true,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Text('Reset'),
              onPressed: resetGame,
            ),
          ),
        ],
      ),
    );
  }
}

class ShikakuCell {
  int number;
  bool filled;

  ShikakuCell({required this.number, required this.filled});
}
