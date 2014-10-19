/* Module imports */
?- ['../engine/engine'].

/**
* alphabeta_ai/4
* Play with the alphabeta algorithm
* @1: +Player - The player running the ai
* @2: +Board - The board to play on
* @3: -Row - The row where alphabeta will play
* @4: -Col - The column where alphabeta will play
*/
alphabeta_ai(Player, Board, Row, Col) :-
  alphabeta(Player, Board, Player, [Row, Col], _, 3, -5000, 5000).

/**
* terminal/4
* Succeeds when the game is over/we are too deep in the search tree and returns the score of the IA's player.
* @1: +Board - The state of the board
* @2: +FavPlayer - The player the IA is playing
* @3: -Value - The value associated to this game.
* @4: +Depth - The current depth in the search tree
*/
terminal(Board, FavPlayer, Value, _) :-
  is_finished(Board),
  score(Board, FavPlayer, Value), 
  !.

terminal(Board, FavPlayer, Value, Depth) :-
  Depth == 0, 
  score(Board, FavPlayer, Value), 
  !.

/**
* alphabeta/8
* Choose the best move for a player using the alphabeta algorithm.
* @1: +FavPlayer - The player the IA is playing
* @2: +Board - The state of the board
* @3: +Player - The current player
* @4: -BestMove - The best move to make
* @5: -Value - The value (fitness) associated with the best move
* @6: +Depth - The current depth in the search tree
* @7: +Alpha - Alpha value
* @8: +Beta - Beta value
*/

alphabeta(FavPlayer, Board, _, _, Value, Depth, Alpha, Beta) :-
  terminal(Board, FavPlayer, Value, Depth),
  !.

alphabeta(FavPlayer, Board, Player, BestMove, Value, Depth, Alpha, Beta) :- 
  all_possible_plays(Player, Board, Moves),
  bestMove(FavPlayer, Board, Player, Moves, BestMove, Value, Depth, Alpha, Beta).
  
/**
* bestMove/9
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
*/
  
% No possible move
bestMove(FavPlayer, Board, Player, [], _, Value, Depth, Alpha, Beta) :- 
  !,
  NewDepth is Depth - 1,
  
  reverse_pawn(Player, OtherPlayer),
  
  alphabeta(FavPlayer, Board, OtherPlayer, _, Value, NewDepth, Alpha, Beta).

% One possible move
bestMove(FavPlayer, Board, Player, [[Row, Col]], [Row, Col], Value, Depth, Alpha, Beta) :- 
  !,
  NewDepth is Depth - 1,
  
  flip_pawns(Board, Row, Col, Player, NewBoard),
  reverse_pawn(Player, OtherPlayer),
  
  alphabeta(FavPlayer, NewBoard, OtherPlayer, _, Value, NewDepth, Alpha, Beta).

% General case
bestMove(FavPlayer, Board, Player, [[Row, Col]|OtherMoves], BestMove, BestValue, Depth, Alpha, Beta) :-
  NewDepth is Depth - 1,
  
  flip_pawns(Board, Row, Col, Player, NewBoard),
  reverse_pawn(Player, OtherPlayer),
  
  alphabeta(FavPlayer, NewBoard, OtherPlayer, _, Value, NewDepth, Alpha, Beta),
  newAlphaBeta(FavPlayer, Player, Value, Alpha, Beta, NewAlpha, NewBeta),
  cutoff(FavPlayer, Board, Player, [Row, Col], Value, OtherMoves, BestMove, BestValue, Depth, NewAlpha, NewBeta).

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
* cutoff/11
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
*/
cutoff(FavPlayer, _, Player, CurrentMove, CurrentValue, _, CurrentMove, CurrentValue, _, Alpha, Beta) :-
  Beta =< Alpha.

cutoff(FavPlayer, Board, Player, CurrentMove, CurrentValue, OtherMoves, BestMove, BestValue, Depth, Alpha, Beta) :-
  bestMove(FavPlayer, Board, Player, OtherMoves, BestMoveFromTail, BestValueFromTail, Depth, Alpha, Beta),
  choose(FavPlayer, Player, CurrentMove, CurrentValue, BestMoveFromTail, BestValueFromTail, BestMove, BestValue).

/**
* choose/8
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
choose(FavPlayer, Player, Move1, Val1, _, Val2, Move1, Val1) :-
  FavPlayer == Player,
  Val1 > Val2,
  !.
choose(FavPlayer, Player, Move1, Val1, _, Val2, Move1, Val1) :-
  FavPlayer \== Player,
  Val1 < Val2,
  !.
choose(_, _, _, _, Move2, Val2, Move2, Val2).
