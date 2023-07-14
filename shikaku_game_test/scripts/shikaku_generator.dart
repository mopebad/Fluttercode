// ignore_for_file: avoid_print

import "dart:math";

void main() {
  for (var i = 0; i < 10000; i++) {
    var a = generateShikakuList();
    var smallestArea = checkSmallestRectangleArea(a);
    if (smallestArea > 1) {
      print(a);
      print(smallestArea);
      print(convertToZeroAndFillRectangle(a));
    }
  }
}

List<List<int>> generateShikakuList({int numRows = 7, int numCols = 7}) {
  List<List<int>> shikakuList = List.generate(numRows, (i) => List.filled(numCols, 0));
  Random random = Random();
  int rectNumber = 1;
  bool allOccupied = false;
  int retries = 0;

  while (!allOccupied) {
    int rectWidth = 0;
    int rectHeight = 0;
    if (retries == 5) {
      rectWidth = numCols;
      rectHeight = numRows;
    } else {
      do {
        rectWidth = random.nextInt(numCols - 1) + 1;
        rectHeight = random.nextInt(numRows - 1) + 1;
      } while (rectWidth * rectHeight < 2);
    }

    List<int> lineCoords = _findLineCoords(shikakuList, rectWidth, rectHeight, random, retries);
    if (lineCoords.isEmpty) {
      retries++;
      if (retries == 10) {
        break;
      } else {
        continue;
      }
    }

    for (int r = lineCoords[0]; r < lineCoords[1]; r++) {
      for (int c = lineCoords[2]; c < lineCoords[3]; c++) {
        shikakuList[r][c] = rectNumber;
      }
    }

    rectNumber++;
    allOccupied = true;
    for (int r = 0; r < numRows; r++) {
      for (int c = 0; c < numCols; c++) {
        if (shikakuList[r][c] == 0) {
          allOccupied = false;
          break;
        }
      }
      if (!allOccupied) break;
    }
  }

  if (!allOccupied) {
    for (int r = 0; r < numRows; r++) {
      for (int c = 0; c < numCols; c++) {
        if (shikakuList[r][c] == 0) {
          shikakuList[r][c] = rectNumber;
          rectNumber++;
        }
      }
    }
  }

  for (int r = 0; r < numRows; r++) {
    for (int c = 0; c < numCols; c++) {
      if (shikakuList[r][c] != 0) {
        int rectNum = shikakuList[r][c];
        int rectWidth = 0;
        int rectHeight = 0;
        for (int i = c; i < numCols; i++) {
          if (shikakuList[r][i] == rectNum) {
            rectWidth++;
          } else {
            break;
          }
        }
        for (int i = r; i < numRows; i++) {
          if (shikakuList[i][c] == rectNum) {
            rectHeight++;
          } else {
            break;
          }
        }
        for (int i = r; i < r + rectHeight; i++) {
          for (int j = c; j < c + rectWidth; j++) {
            if (shikakuList[i][j] == 0) {
              shikakuList[i][j] = rectNum;
            }
          }
        }
      }
    }
  }

  return shikakuList;
}

List<int> _findLineCoords(List<List<int>> shikakuList, int rectWidth, int rectHeight, Random random, int retries) {
  for (int i = 0; i < 10; i++) { // try 10 times to find a valid position
    int rectRow = random.nextInt(shikakuList.length - rectHeight + 1);
    int rectCol = random.nextInt(shikakuList[0].length - rectWidth + 1);
    bool overlaps = false;
    for (int r = rectRow; r < rectRow + rectHeight; r++) {
      for (int c = rectCol; c < rectCol + rectWidth; c++) {
        if (shikakuList[r][c] != 0) {
          overlaps = true;
          break;
        }
      }
      if (overlaps) break;
    }
    if (!overlaps) {
      return [rectRow, rectRow + rectHeight, rectCol, rectCol + rectWidth];
    }
  }
  return [];
}

int checkSmallestRectangleArea(List<List<int>> shikakuList) {
  int smallestArea = shikakuList.length * shikakuList[0].length;
  for (int rectNum = 1; rectNum <= shikakuList.length * shikakuList[0].length; rectNum++) {
    int rectWidth = 0;
    int rectHeight = 0;
    int topLeftRow = -1;
    int topLeftCol = -1;
    for (int r = 0; r < shikakuList.length; r++) {
      for (int c = 0; c < shikakuList[0].length; c++) {
        if (shikakuList[r][c] == rectNum) {
          if (topLeftRow == -1 || r < topLeftRow) {
            topLeftRow = r;
          }
          if (topLeftCol == -1 || c < topLeftCol) {
            topLeftCol = c;
          }
          rectWidth = max(rectWidth, c - topLeftCol + 1);
          rectHeight = max(rectHeight, r - topLeftRow + 1);
        }
      }
    }
    if (rectWidth * rectHeight > 0) {
      smallestArea = min(smallestArea, rectWidth * rectHeight);
    }
  }
  return smallestArea;
}

List<List<int>> convertToZeroAndFillRectangle(List<List<int>> shikakuList) {
  List<List<int>> zeroList = List.generate(shikakuList.length, (_) => List.filled(shikakuList[0].length, 0));
  for (int rectNum = 1; rectNum <= shikakuList.length * shikakuList[0].length; rectNum++) {
    int rectWidth = 0;
    int rectHeight = 0;
    int topLeftRow = -1;
    int topLeftCol = -1;
    for (int r = 0; r < shikakuList.length; r++) {
      for (int c = 0; c < shikakuList[0].length; c++) {
        if (shikakuList[r][c] == rectNum) {
          if (topLeftRow == -1 || r < topLeftRow) {
            topLeftRow = r;
          }
          if (topLeftCol == -1 || c < topLeftCol) {
            topLeftCol = c;
          }
          rectWidth = max(rectWidth, c - topLeftCol + 1);
          rectHeight = max(rectHeight, r - topLeftRow + 1);
        }
      }
    }
    if (rectWidth * rectHeight >= 2) {
      int randRow = Random().nextInt(rectHeight) + topLeftRow;
      int randCol = Random().nextInt(rectWidth) + topLeftCol;
      print("x: $topLeftCol, y: $topLeftRow, rectWidth: $rectWidth, rectHeight: $rectHeight, randRow: $randRow, randCol: $randCol, rectNum: $rectNum, area: ${rectWidth * rectHeight}");
      zeroList[randRow][randCol] = rectWidth * rectHeight;
    }    
  }
  return zeroList;
}