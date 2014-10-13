/**
 * Relation: admissible_plays/3
 * Asserts the space of playable pawn postions
 * @1: +CurrentPlayer - b or w
 * @2: +Board - the board to play on
 * @3: -Row - the row to play on
 * @4: -Column - the column to play on
 */
admissible_plays(CurrentPlayer, Board, Row, Col) :-
  admissible_in_dir(CurrentPlayer, Board, Row, Col, -1, -1). % true in every direction
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
 * @1: +CurrentPlayer - b or w
 * @2: +Board - the board to play on
 * @3: ?Row - the row to play on
 * @4: ?Column - the column to play on
 * @5: +DirRow - the row direction for the exploration (-1, 0 or +1)
 * @6: +DirCol - the col direction for the exploration (-1, 0 or +1)
 */
admissible_in_dir(CurrentPlayer, Board, Row, Col, RowDir, ColDir) :-
  pawn(Board, Row, Col, e), % the current position is empty
  reverse_pawn(CurrentPlayer, OppositePlayer), % take the opposite player
  has_neighbor(Board, Row, Col, RowDir, ColDir, OppositePlayer), % if the direct neighbor in the direction is opposite
  surrounds(Board, Row, Col, RowDir, ColDir, CurrentPlayer). % if in this direction, we can find another from the same color

/**
 * Relation: has_neighbor/6
 * Asserts if the pawn is next to a neighbor in one direction
 * @1: +Board - the board to play on
 * @2: ?Row - the row of the origin
 * @3: ?Column - the column of the origin
 * @4: +DirRow - the row direction for the exploration (-1, 0 or +1)
 * @5: +DirCol - the col direction for the exploration (-1, 0 or +1)
 * @6: +Type - the neighbor type to assert
 */
has_neighbor(Board, Row, Col, DirRow, DirCol, Type) :-
  between(0, 7, RowDelta), % Constrains the deltas in board
  between(0, 7, ColDelta),
  RowDelta is Row + DirRow, % Push the deltas in directions
  ColDelta is Col + DirCol,
  pawn(Board, RowDelta, ColDelta, Type). % Assert in the new positions

/**
 * Relation: surrounds/6
 * Asserts if the pawn has a same-type pawn in one direction
 * @1: +Board - the board to play on
 * @2: ?Row - the row of the origin
 * @3: ?Column - the column of the origin
 * @4: +DirRow - the row direction for the exploration (-1, 0 or +1)
 * @5: +DirCol - the col direction for the exploration (-1, 0 or +1)
 * @6: +Type - the surrounding type to assert
 */
surrounds(Board, Row, Col, DirRow, DirCol, Type) :-
  has_neighbor(Board, Row, Col, DirRow, DirCol, Type). % Stops when the type is encountered
surrounds(Board, Row, Col, DirRow, DirCol, Type) :-
  not(has_neighbor(Board, Row, Col, DirRow, DirCol, e)), % Asserts if we're not on an empty case
  IncRow is Row + DirRow, % Increments in the direction
  IncCol is Col + DirCol,
  IncRow > 0, % Check bounds
  IncRow < 8,
  IncCol > 0,
  IncCol < 8,
  surrounds(Board, IncRow, IncCol, DirRow, DirCol, Type). % Continue in the direction

/**
 * Relation: is_finished/1
 * Asserts if the game is finished
 * @1: +Board - the board to play on
 */
is_finished(Board) :-
  not(admissible_plays(w, Board, _, _)),
  not(admissible_plays(b, Board, _, _)).
