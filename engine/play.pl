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

change_pawn(Board, Row, Col, Type, BoardRes) :-
  between(0, 8, CopyRows),
  nth0(CopyRows, Board, CopyLists),
  nth0(CopyRows, BoardRes, CopyLists),
  nth0(Row, Board, List),
  nth0(Row, BoardRes, ListRes),
  not(CopyRows = Row),
  change_in_list(Col, Type, List, ListRes).

copy_list([], []).
copy_list([H|T1], [H|T2]) :- copy_list(T1, T2).

change_in_list(0, Type, [_|T], [Type|T]).
change_in_list(X1, Type, [H|T1], [H|T2]) :-
  X2 is X1 - 1,
  change_in_list(X2, Type, T1, T2).
