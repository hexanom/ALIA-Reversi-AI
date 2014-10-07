/**
 * Relation: admissible_plays/4
 * Gives the space of playable pawn postions
 * @1: CurrentPlayer - the current player
 * @2: Row - the row to play on
 * @3: Column - the column to play on
 */
admissible_plays(Board, CurrentPlayer, Row, Col) :-
  board(Board),
  pawn(Board, Row, Col, e),
  reverse_pawn(CurrentPlayer, Type),
  pawn(Board, Row - 1, Col, Type).
admissible_plays(Board, CurrentPlayer, Row, Col) :-
  board(Board),
  pawn(Board, Row, Col, e),
  reverse_pawn(CurrentPlayer, Type),
  pawn(Board, Row + 1, Col, Type).
admissible_plays(Board, CurrentPlayer, Row, Col) :-
  board(Board),
  pawn(Board, Row, Col, e),
  reverse_pawn(CurrentPlayer, Type),
  pawn(Board, Row, Col + 1, Type).
admissible_plays(Board, CurrentPlayer, Row, Col) :-
  board(Board),
  pawn(Board, Row, Col, e),
  reverse_pawn(CurrentPlayer, Type),
  pawn(Board, Row, Col + 1, Type).
admissible_plays(Board, CurrentPlayer, Row, Col) :-
  board(Board),
  pawn(Board, Row, Col, e),
  reverse_pawn(CurrentPlayer, Type),
  pawn(Board, Row - 1, Col - 1, Type).
admissible_plays(Board, CurrentPlayer, Row, Col) :-
  board(Board),
  pawn(Board, Row, Col, e),
  reverse_pawn(CurrentPlayer, Type),
  pawn(Board, Row + 1, Col + 1, Type).
admissible_plays(Board, CurrentPlayer, Row, Col) :-
  board(Board),
  pawn(Board, Row, Col, e),
  reverse_pawn(CurrentPlayer, Type),
  pawn(Board, Row + 1, Col - 1, Type).
admissible_plays(Board, CurrentPlayer, Row, Col) :-
  board(Board),
  pawn(Board, Row, Col, e),
  reverse_pawn(CurrentPlayer, Type),
  pawn(Board, Row - 1, Col + 1, Type).
