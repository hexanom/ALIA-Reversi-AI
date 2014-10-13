/**
 * Relation: admissible_plays/3
 * Gives the space of playable pawn postions
 * @1: CurrentPlayer - b or w
 * @2: Board - the board to play on
 * @1: Row - the row to play on
 * @2: Column - the column to play on
 */
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  between(0, 7, Row),
  between(0, 7, RowDelta),
  between(0, 7, Col),
  between(0, 7, ColDelta),
  RowDelta >= Row - 1,
  RowDelta =< Row + 1,
  ColDelta >= Col - 1,
  ColDelta =< Col + 1,
  pawn(Board, Row, Col, e),
  reverse_pawn(CurrentPlayer, OppositePlayer),
  pawn(Board, RowDelta, ColDelta, OppositePlayer).
