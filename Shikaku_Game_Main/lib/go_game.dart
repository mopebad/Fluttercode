enum GoColor { white, black }

class GoPiece {
  final int x;
  final int y;
  final GoColor? color;

  GoPiece(this.x, this.y, this.color);
}

bool shouldRemovePiece(GoPiece piece, List<GoPiece> board) {
  // Check if the piece has any liberties
  final liberties = getLiberties(piece, board);
  if (liberties.isNotEmpty) {
    return false;
  }

  // Check if the piece is part of a group with any liberties
  final group = getGroup(piece, board);
  for (final p in group) {
    final liberties = getLiberties(p, board);
    if (liberties.isNotEmpty) {
      return false;
    }
  }

  // If the piece and its group have no liberties, remove it from the board
  return true;
}

Set<GoPiece> getGroup(GoPiece piece, List<GoPiece> board) {
  final visited = <GoPiece>{};
  final group = <GoPiece>{piece};

  void dfs(GoPiece p) {
    if (!visited.contains(p)) {
      visited.add(p);
      final neighbors = getAdjacentSameColor(p, board);
      for (final neighbor in neighbors) {
        if (!group.contains(neighbor)) {
          group.add(neighbor);
          dfs(neighbor);
        }
      }
    }
  }

  dfs(piece);
  return group;
}

Set<GoPiece> getAdjacentSameColor(GoPiece piece, List<GoPiece> board) {
  final adjacent = <GoPiece>{};
  for (final p in board) {
    if (p.color == piece.color) {
      if ((p.x == piece.x && (p.y == piece.y - 1 || p.y == piece.y + 1)) ||
          (p.y == piece.y && (p.x == piece.x - 1 || p.x == piece.x + 1))) {
        adjacent.add(p);
      }
    }
  }
  return adjacent;
}

Set<GoPiece> getLiberties(GoPiece piece, List<GoPiece> board) {
  final liberties = <GoPiece>{};
  for (final p in getAdjacentEmpty(piece, board)) {
    liberties.addAll(getAdjacentSameColor(p, board));
  }
  return liberties;
}

Set<GoPiece> getAdjacentEmpty(GoPiece piece, List<GoPiece> board) {
  final adjacent = <GoPiece>{};
  for (final p in board) {
    if (p.color == null) {
      if ((p.x == piece.x && (p.y == piece.y - 1 || p.y == piece.y + 1)) ||
          (p.y == piece.y && (p.x == piece.x - 1 || p.x == piece.x + 1))) {
        adjacent.add(p);
      }
    }
  }
  return adjacent;
}