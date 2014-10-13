/**
 * Relation: admissible_plays/3
 * Gives the space of playable pawn postions
 * @1: Row - the row to play on
 * @2: Column - the column to play on
 */
admissible_plays(Row, Col) :-
  current_player(CurrentPlayer),
  RowM1 is Row - 1, /* PB */
  RowP1 is Row + 1,
  ColM1 is Col - 1,
  ColP1 is Col + 1,
  between(RowM1, RowP1, RowDelta), /* Warining: between not supported on INSA's computers */
  between(ColM1, ColP1, ColDelta),
  pawn(Row, Col, e),
  reverse_pawn(CurrentPlayer, Type),
  pawn(RowDelta, ColDelta, Type).
