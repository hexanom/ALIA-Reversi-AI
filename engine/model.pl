/**
 * Relation: is_inbound/2
 * Defines if the Row & Col are in the board indexes
 * @1: +Row - the row to assert
 * @2: +Col - the column to assert
 */
is_inbound(Row, Col) :-
  between(0, 7, Row),
  between(0, 7, Col).

/**
 * Relation: pawn/4
 * Succeeds if Pawn is on the Board at the given Row and Col indexes
 * @1: +Board - the board to play on
 * @2: +Row - the row on the board
 * @3: +Col - the column on the board
 * @4: +Type - the type of pawn (e: empty, w: white, b: black)
 */
pawn(Board, Row, Col, Type) :-
  is_inbound(Row, Col),
  nth0(Row, Board, List),
  nth0(Col, List, Type).

/**
 * Relation: reverse_pawn/2
 * Gives the opposite type for w and b types
 * @1: +Type - the type to reverse
 * @2: -Reverse - the reversed Type
 */
reverse_pawn(w, b).
reverse_pawn(b, w).
