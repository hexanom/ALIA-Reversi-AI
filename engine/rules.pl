/**
 * Relation: admissible_plays/3
 * Gives the space of playable pawn postions
 * @1: CurrentPlayer - b or w
 * @2: Board - the board to play on
 * @3: Row - the row to play on
 * @4: Column - the column to play on
 */
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  RowM1 is Row - 1, /* PB */
  RowP1 is Row + 1,
  ColM1 is Col - 1,
  ColP1 is Col + 1,
  between(RowM1, RowP1, RowDelta), /* Warining: between not supported on INSA's computers */
  between(ColM1, ColP1, ColDelta),
  pawn(Row, Col, e),
  reverse_pawn(CurrentPlayer, Type),
  pawn(RowDelta, ColDelta, Type).

/**
 * Relation: is_finished/1
 * True when the game is finished
 * @1: Board - the board to play on
 */
 is_finished(Board) :-
     not(admissible_plays(w, Board, _, _)),
     not(admissible_plays(b, Board, _, _)).
