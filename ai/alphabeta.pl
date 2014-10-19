/* Module imports */
?- ['../engine/engine'].

/**
* alphabeta_ai/5
* Play with the alphabeta algorithm
* @1: +Player - The player running the ai
* @2: +Board - The board to play on
* @3: +Heuristic - Heuristic (predicate) used to evaluate the state of the board
* @4: -Row - The row where alphabeta will play
* @5: -Col - The column where alphabeta will play
*/
alphabeta_ai(Player, Board, Row, Col, Heuristic) :-
  feature(min_tagged_integer, Alpha),
  feature(max_tagged_integer, Beta),
  alphabeta(Player, Board, Player, [Row, Col], _, 3, Alpha, Beta, Heuristic).

% Fallback
alphabeta_ai(Player, Board, Row, Col, Heuristic) :-
  alphabeta(Player, Board, Player, [Row, Col], _, 3, -9999, 9999, Heuristic).

/**
* alphabeta_terminal/5
* Succeeds when the game is over/we are too deep in the search tree and returns the score of the IA's player.
* @1: +Board - The state of the board
* @2: +FavPlayer - The player the IA is playing
* @3: -Value - The value associated to this game.
* @4: +Depth - The current depth in the search tree
* @5: +Heuristic - Heuristic (predicate) used to evaluate the state of the board
*/
alphabeta_terminal(Board, FavPlayer, Value, _, Heuristic) :-
  is_finished(Board),
  call(Heuristic, Board, FavPlayer, Value), 
  !.

alphabeta_terminal(Board, FavPlayer, Value, Depth, Heuristic) :-
  Depth == 0,
  call(Heuristic, Board, FavPlayer, Value), 
  !.

/**
* alphabeta/9
* Choose the best move for a player using the alphabeta algorithm.
* @1: +FavPlayer - The player the IA is playing
* @2: +Board - The state of the board
* @3: +Player - The current player
* @4: -BestMove - The best move to make
* @5: -Value - The value (fitness) associated with the best move
* @6: +Depth - The current depth in the search tree
* @7: +Alpha - Alpha value
* @8: +Beta - Beta value
* @9: +Heuristic - Heuristic (predicate) used to evaluate the state of the board
*/

alphabeta(FavPlayer, Board, _, _, Value, Depth, _, _, Heuristic) :-
  alphabeta_terminal(Board, FavPlayer, Value, Depth, Heuristic),
  !.

alphabeta(FavPlayer, Board, Player, BestMove, Value, Depth, Alpha, Beta, Heuristic) :- 
  all_possible_plays(Player, Board, Moves),
  alphabeta_bestMove(FavPlayer, Board, Player, Moves, BestMove, Value, Depth, Alpha, Beta, Heuristic).
  
/**
* alphabeta_bestMove/10
* Choose the best move between all possible move for a player.
* @1: +FavPlayer - The player the IA is playing
* @2: +Board - The state of the board
* @3: +Player - The player who will play this move
* @4: +Moves - The possible moves for player
* @5: -BestMove - The best move to make
* @6: -BestValue - The value (fitness) associated to the best move to make
* @7: +Depth - The current depth in the search tree
* @8: +Alpha - Alpha value
* @9: +Beta - Beta value
* @10: +Heuristic - Heuristic (predicate) used to evaluate the state of the board
*/
  
% No possible move
alphabeta_bestMove(FavPlayer, Board, Player, [], _, Value, Depth, Alpha, Beta, Heuristic) :- 
  !,
  NewDepth is Depth - 1,
  
  reverse_pawn(Player, OtherPlayer),
  
  alphabeta(FavPlayer, Board, OtherPlayer, _, Value, NewDepth, Alpha, Beta, Heuristic).

% One possible move
alphabeta_bestMove(FavPlayer, Board, Player, [[Row, Col]], [Row, Col], Value, Depth, Alpha, Beta, Heuristic) :- 
  !,
  NewDepth is Depth - 1,
  
  flip_pawns(Board, Row, Col, Player, NewBoard),
  reverse_pawn(Player, OtherPlayer),
  
  alphabeta(FavPlayer, NewBoard, OtherPlayer, _, Value, NewDepth, Alpha, Beta, Heuristic).

% General case
alphabeta_bestMove(FavPlayer, Board, Player, [[Row, Col]|OtherMoves], BestMove, BestValue, Depth, Alpha, Beta, Heuristic) :-
  NewDepth is Depth - 1,
  
  flip_pawns(Board, Row, Col, Player, NewBoard),
  reverse_pawn(Player, OtherPlayer),
  
  alphabeta(FavPlayer, NewBoard, OtherPlayer, _, Value, NewDepth, Alpha, Beta, Heuristic),
  newAlphaBeta(FavPlayer, Player, Value, Alpha, Beta, NewAlpha, NewBeta),
  cutoff(FavPlayer, Board, Player, [Row, Col], Value, OtherMoves, BestMove, BestValue, Depth, NewAlpha, NewBeta, Heuristic).

/**
* newAlphaBeta/7
* Updates alpha or beta depending on the current player
* @1: +FavPlayer - The player the IA is playing
* @2: +Player - The player who will play this move
* @3: +Value - Alpha or beta value (depending on the player)
* @4: +Alpha - Alpha value
* @5: +Beta - Beta value
* @6: -NewAlpha - Updated alpha value
* @7: -NewBeta - Updated beta value
*/
newAlphaBeta(FavPlayer, Player, Value, Alpha, Beta, NewAlpha, Beta) :-
  FavPlayer == Player,
  NewAlpha is max(Alpha, Value).

newAlphaBeta(FavPlayer, Player, Value, Alpha, Beta, Alpha, NewBeta) :-
  FavPlayer \== Player,
  NewBeta is min(Beta, Value).

/**
* cutoff/12
* Cuts off OR continue looking into the search tree depending alpha and beta values
* @1: +FavPlayer - The player the IA is playing
* @2: +Board - The state of the board
* @3: +Player - The player who will play this move
* @4: +CurrentMove - The move we just made
* @5: +CurrentValue - The value associated to the move we just made
* @6: +OtherMoves - The other possible moves for player
* @7: -BestMove - The best move to make
* @8: -BestValue - The value (fitness) associated to the best move to make
* @9: +Depth - The current depth in the search tree
* @10: +Alpha - Alpha value
* @11: +Beta - Beta value
* @12: +Heuristic - Heuristic (predicate) used to evaluate the state of the board
*/
cutoff(_ , _, _, CurrentMove, CurrentValue, _, CurrentMove, CurrentValue, _, Alpha, Beta) :-
  Beta =< Alpha.

cutoff(FavPlayer, Board, Player, CurrentMove, CurrentValue, OtherMoves, BestMove, BestValue, Depth, Alpha, Beta, Heuristic) :-
  alphabeta_bestMove(FavPlayer, Board, Player, OtherMoves, BestMoveFromTail, BestValueFromTail, Depth, Alpha, Beta, Heuristic),
  alphabeta_choose(FavPlayer, Player, CurrentMove, CurrentValue, BestMoveFromTail, BestValueFromTail, BestMove, BestValue).

/**
* alphabeta_choose/8
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
alphabeta_choose(FavPlayer, Player, Move1, Val1, _, Val2, Move1, Val1) :-
  FavPlayer == Player,
  Val1 > Val2,
  !.
alphabeta_choose(FavPlayer, Player, Move1, Val1, _, Val2, Move1, Val1) :-
  FavPlayer \== Player,
  Val1 < Val2,
  !.
alphabeta_choose(_, _, _, _, Move2, Val2, Move2, Val2).
