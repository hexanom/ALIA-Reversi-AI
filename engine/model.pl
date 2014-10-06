/**
 * Relation: pawn/4
 * Succeeds if Pawn is on the Board at the given Row and Col indexes
 * @1: Board - the board of the current game state
 * @2: Row - the row on the board
 * @3: Col - the column on the board
 * @4: Type - the type of pawn (e: empty, w: white, b: black)
 */
pawn(Board, Row, Col, Type) :-
  nth0(Row, Board, List),
  nth0(Col, List, Type).

/**
 * Relation: reverse_pawn/2
 * Gives the opposite type for w and b types
 * @1: Type - the type to reverse
 * @2: Reverse - the reversed Type
 */
reverse_pawn(w, b).
reverse_pawn(b, w).
