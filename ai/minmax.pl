/* Module imports */
?- ['../engine/engine'].

/**
* alphabeta_ai/4
* Play with the minmax algorithm
* @1: +Player - The player running the ai
* @2: +Board - The board to play on
* @3: +Heuristic - Heuristic (predicate) used to evaluate the state of the board
* @4: -Row - The row where minmax will play
* @5: -Col - The column where minmax will play
*/
minmax_ai(Player, Board, Row, Col, Heuristic) :-
  minimax(Player, Board, Player, [Row, Col], _, 2, Heuristic).

/**
* minmax_terminal/5
* Succeeds when the game is over/we are too deep in the search tree and returns the score of the IA's player.
* @1: +Board - The state of the board
* @2: +FavPlayer - The player the IA is playing
* @3: -Value - The value associated to this game.
* @4: +Depth - The current depth in the search tree
* @5: +Heuristic - Heuristic (predicate) used to evaluate the state of the board
*/
minmax_terminal(Board, FavPlayer, Value, _, Heuristic) :-
  is_finished(Board),
  call(Heuristic, Board, FavPlayer, Value), 
  !.

minmax_terminal(Board, FavPlayer, Value, Depth, Heuristic) :-
  Depth == 0, 
  call(Heuristic, Board, FavPlayer, Value), 
  !.

/**
* minimax/7
* Choose the best move for a player using the minmax algorithm.
* @1: +FavPlayer - The player the IA is playing
* @2: +Board - The state of the board
* @3: +Player - The current player
* @4: -BestMove - The best move to make
* @5: -Value - The value (fitness) associated with the best move
* @6: +Depth - The current depth in the search tree
* @7: +Heuristic - Heuristic (predicate) used to evaluate the state of the board
*/

minimax(FavPlayer, Board, _, _, Value, Depth, Heuristic) :-
  minmax_terminal(Board, FavPlayer, Value, Depth, Heuristic),
  !.

minimax(FavPlayer, Board, Player, BestMove, Value, Depth, Heuristic) :- 
  all_possible_plays(Player, Board, Moves),
  minmax_bestMove(FavPlayer, Board, Player, Moves, BestMove, Value, Depth, Heuristic).
  
/**
* minmax_bestMove/8
* Choose the best move between all possible move for a player.
* @1: +FavPlayer - The player the IA is playing
* @2: +Board - The state of the board
* @3: +Player - The player who will play this move
* @4: +Moves - The possible moves for player
* @5: -BestMove - The best move to make
* @6: -BestValue - The value (fitness) associated to the best move to make
* @7: +Depth - The current depth in the search tree
* @8: +Heuristic - Heuristic (predicate) used to evaluate the state of the board
*/
  
% No possible move
minmax_bestMove(FavPlayer, Board, Player, [], _, Value, Depth, Heuristic) :- 
  !,
  NewDepth is Depth - 1,
  
  reverse_pawn(Player, OtherPlayer),
  
  minimax(FavPlayer, Board, OtherPlayer, _, Value, NewDepth, Heuristic).

% One possible move
minmax_bestMove(FavPlayer, Board, Player, [[Row, Col]], [Row, Col], Value, Depth, Heuristic) :- 
  !,
  NewDepth is Depth - 1,
  
  flip_pawns(Board, Row, Col, Player, NewBoard),
  reverse_pawn(Player, OtherPlayer),
  
  minimax(FavPlayer, NewBoard, OtherPlayer, _, Value, NewDepth, Heuristic).

% General case
minmax_bestMove(FavPlayer, Board, Player, [[Row, Col]|OtherMoves], BestMove, BestValue, Depth, Heuristic) :-
  NewDepth is Depth - 1,
  
  flip_pawns(Board, Row, Col, Player, NewBoard),
  reverse_pawn(Player, OtherPlayer),
  
  minimax(FavPlayer, NewBoard, OtherPlayer, _, ValueFromFirst, NewDepth, Heuristic),
  minmax_bestMove(FavPlayer, Board, Player, OtherMoves, MoveFromTail, ValueFromTail, Depth, Heuristic),
  
  minmax_choose(FavPlayer, Player, [Row, Col], ValueFromFirst, MoveFromTail, ValueFromTail, BestMove, BestValue).
  
/**
* minmax_choose/8
* Choose the best move between two moves.
* @1: +FavPlayer - The player the IA is playing
* @2: +Player - The player who will play this move
* @3: +Move1 - First move to compare
* @4: +Val1 - The value (fitness) associated to Move1
* @5: +Move2 - Second move to compare
* @6: +Val2 - The value (fitness) associated to Move2
* @7: -BestMove - The best move between both moves
* @8: -BestValue - The value associated with the best move
*/
minmax_choose(FavPlayer, Player, Move1, Val1, _, Val2, Move1, Val1) :-
  FavPlayer == Player,
  Val1 > Val2,
  !.
minmax_choose(FavPlayer, Player, Move1, Val1, _, Val2, Move1, Val1) :-
  FavPlayer \== Player,
  Val1 < Val2,
  !.
minmax_choose(_, _, _, _, Move2, Val2, Move2, Val2).
