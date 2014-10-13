/* Package imports */
?- [model].

/**
 * Relation: play_pawn/2
 * @1: Row - the row to play on
 * @2: Column - the column to play on
 */
play_pawn(Row, Col) :-
  current_player(Type),
  board(Board),
  change_pawn(Board, Row, Col, Type, BoardRes),
  retract(board(Board)),
  assert(board(BoardRes)),
  reverse_pawn(Type, TypeRes),
  retract(current_player(Type)),
  assert(current_player(TypeRes)).

/**
 * Relation: change_pawn/4
 * @1: Board - the original board
 * @2: Row - the row to change
 * @3: Column - the column to change
 * @4: Type - the type to put
 * @5: BoardRes - the new board
 */
change_pawn([H1|T], 0, Col, Type, [H2|T]) :- change_in_list(Col, Type, H1, H2).
change_pawn([H|T1], Row1, Col, Type, [H|T2]) :-
  Row2 is Row1 - 1,
  change_pawn(T1, Row2, Col, Type, T2).

/**
 * Relation: change_in_list/4
 * @1: Index - The index to change
 * @2: Type - to this type
 * @3: Origin - the original list
 * @4: New - the new list
 */
change_in_list(0, Type, [_|T], [Type|T]).
change_in_list(X1, Type, [H|T1], [H|T2]) :-
  X2 is X1 - 1,
  change_in_list(X2, Type, T1, T2).
