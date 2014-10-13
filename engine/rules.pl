/**
 * Relation: admissible_plays/3
 * Asserts the space of playable pawn postions
 * @1: CurrentPlayer - b or w
 * @2: Board - the board to play on
 * @3: Row - the row to play on
 * @4: Column - the column to play on
 */
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  admissible_in_dir(CurrentPlayer, Board, Row, Col, -1, -1).
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  admissible_in_dir(CurrentPlayer, Board, Row, Col, +1, +1).
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  admissible_in_dir(CurrentPlayer, Board, Row, Col, -1, +1).
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  admissible_in_dir(CurrentPlayer, Board, Row, Col, +1, -1).
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  admissible_in_dir(CurrentPlayer, Board, Row, Col, -1, 0).
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  admissible_in_dir(CurrentPlayer, Board, Row, Col, 0, -1).
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  admissible_in_dir(CurrentPlayer, Board, Row, Col, +1, 0).
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  admissible_in_dir(CurrentPlayer, Board, Row, Col, 0, +1).

/**
 * Relation: admissible_in_dir/6
 * Asserts if the next pawn in one direction is admissible
 * @1: CurrentPlayer - b or w
 * @2: Board - the board to play on
 * @3: Row - the row to play on
 * @4: Column - the column to play on
 * @5: DirRow - the row direction for the exploration (-1, 0 or +1)
 * @6: DirCol - the col direction for the exploration (-1, 0 or +1)
 */
admissible_in_dir(CurrentPlayer, Board, Row, Col, RowDir, ColDir) :-
  pawn(Board, Row, Col, e),
  reverse_pawn(CurrentPlayer, OppositePlayer),
  has_neighbor(Board, Row, Col, RowDir, ColDir, OppositePlayer),
  surrounds(Board, Row, Col, RowDir, ColDir, CurrentPlayer).

/**
 * Relation: has_neighbor/6
 * Asserts if the pawn is next to a neighbor in one direction
 * @1: Board - the board to play on
 * @2: Row - the row of the origin
 * @3: Column - the column of the origin
 * @4: DirRow - the row direction for the exploration (-1, 0 or +1)
 * @5: DirCol - the col direction for the exploration (-1, 0 or +1)
 * @6: Type - the neighbor type to assert
 */
has_neighbor(Board, Row, Col, DirRow, DirCol, Type) :-
  between(0, 7, RowDelta),
  between(0, 7, ColDelta),
  RowDelta is Row + DirRow,
  ColDelta is Col + DirCol,
  pawn(Board, RowDelta, ColDelta, Type).

/**
 * Relation: surrounds/6
 * Asserts if the pawn has a same-type pawn in one direction
 * @1: Board - the board to play on
 * @2: Row - the row of the origin
 * @3: Column - the column of the origin
 * @4: DirRow - the row direction for the exploration (-1, 0 or +1)
 * @5: DirCol - the col direction for the exploration (-1, 0 or +1)
 * @6: Type - the surrounding type to assert
 */
surrounds(Board, Row, Col, DirRow, DirCol, Type) :-
  has_neighbor(Board, Row, Col, DirRow, DirCol, Type).
surrounds(Board, Row, Col, DirRow, DirCol, Type) :-
  not(has_neighbor(Board, Row, Col, DirRow, DirCol, e)),
  IncRow is Row + DirRow,
  IncCol is Col + DirCol,
  surrounds(Board, IncRow, IncCol, DirRow, DirCol, Type).

