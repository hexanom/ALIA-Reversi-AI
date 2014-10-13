/* Package imports */
?- [model].
?- [rules].

/**
 * Relation: play_pawn/2
 * Play a pawn and assert the new board and player
 * @1: +Row - the row to play on
 * @2: +Column - the column to play on
 */
play_pawn(Row, Col) :-
  current_player(Type), % Get the current player
  board(Board), % Get the current board
  admissible_plays(Type, Board, Row, Col), % Asserts if admissible
  flip_pawns(Board, Row, Col, Type, NewBoard), % Flip the pawns
  retract(board(Board)), % Retract Board
  assert(board(NewBoard)), % Assert the new one
  reverse_pawn(Type, NewType), % Select the next player
  retract(current_player(Type)), % Retract the current player
  assert(current_player(NewType)). % Assert the new player

/**
 * Relation: flip_pawns/5
 * Flips pawn on the row/col position and flips all surroundings in every direction
 * @1: +Board - the original board
 * @2: +Row - the row to play on
 * @3: +Column - the column to play on
 * @4: +Type - the type to put
 * @5: ?NewBoard - the new board
 */
flip_pawns(Board, Row, Col, Type, NewBoard) :-
  change_pawn(Board, Row, Col, Type, Board0), % Changes at this position
  flip_in_dir(Board0, Row, Col, -1, -1, Type, Board1), % And flips in every direction
  flip_in_dir(Board1, Row, Col, +1, +1, Type, Board2),
  flip_in_dir(Board2, Row, Col, -1, +1, Type, Board3),
  flip_in_dir(Board3, Row, Col, +1, -1, Type, Board4),
  flip_in_dir(Board4, Row, Col, -1, 0, Type, Board5),
  flip_in_dir(Board5, Row, Col, 0, -1, Type, Board6),
  flip_in_dir(Board6, Row, Col, +1, 0, Type, Board7),
  flip_in_dir(Board7, Row, Col, 0, +1, Type, NewBoard).

/**
 * Relation: flip_in_dir/7
 * Flips all pawsns on defined direction if surrounding
 * @1: +Board - the original board
 * @2: +Row - the row to play on
 * @3: +Column - the column to play on
 * @4: +RowDir - the row direction
 * @5: +ColDir - the dir direction
 * @6: +Type - the type to put
 * @7: ?NewBoard - the new board
 */
% Not appliable directions
flip_in_dir(Board, Row, Col, DirRow, DirCol, Type, Board) :-
  not(surrounds(Board, Row, Col, DirRow, DirCol, Type)). % Stops if this direction does not surround
% Appliable directions (does surround)
flip_in_dir(Board, Row, Col, DirRow, DirCol, Type, Board) :-
  surrounds(Board, Row, Col, DirRow, DirCol, Type),
  IncRow is Row + DirRow,
  IncCol is Col + DirCol,
  pawn(Board, IncRow, IncCol, Type). % Stops if own type reached (at next incrementation)
flip_in_dir(Board, Row, Col, DirRow, DirCol, Type, NewBoard) :-
  surrounds(Board, Row, Col, DirRow, DirCol, Type),
  IncRow is Row + DirRow,
  IncCol is Col + DirCol,
  not(pawn(Board, IncRow, IncCol, Type)), % the next must not be already the end
  change_pawn(Board, IncRow, IncCol, Type, BoardFlipped), % Flips next
  flip_in_dir(BoardFlipped, IncRow, IncCol, DirRow, DirCol, Type, NewBoard). % …and goes on !

/**
 * Relation: change_pawn/4
 * Change a pawn on the board to another
 * @1: +Board - the original board
 * @2: +Row - the row to change
 * @3: +Column - the column to change
 * @4: +Type - the type to put
 * @5: ?NewBoard - the new board
 */
change_pawn([H1|T], 0, Col, Type, [H2|T]) :-
  change_in_list(Col, Type, H1, H2). % At index 0, do the change
change_pawn([H|T1], Row1, Col, Type, [H|T2]) :-
  Row2 is Row1 - 1, % Decrement until index 0
  change_pawn(T1, Row2, Col, Type, T2).

/**
 * Relation: change_in_list/4
 * Change an item in a list at a given index
 * @1: +Index - The index to change
 * @2: +Type - to this type
 * @3: +Origin - the original list
 * @4: ?New - the new list
 */
change_in_list(0, Type, [_|T], [Type|T]). % At index 0, do the change
change_in_list(X1, Type, [H|T1], [H|T2]) :-
  X2 is X1 - 1, % Decrement until index 0
  change_in_list(X2, Type, T1, T2).
