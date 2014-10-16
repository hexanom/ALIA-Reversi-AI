/* Module imports */
?- ['../engine/engine'].

/**
* minmax_ai/4
* Play with the minmax algorithm
* @1: +Player - The player running the ai
* @2: +Board - The board to play on
* @3: -Row - The row where minmax will play
* @4: -Col - The column where minmax will play
*/
minmax_ai(Player, Board, Row, Col) :-
  minimax(Player, Board, Player, [Row, Col], _, 2).

/**
* terminal/3
* Succeeds when the game is over and returns the score of the IA's player.
* @1: +State - The state of the board
* @2: +Player - The currrent player
* @3: -Value - The value associated to this game.
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
* minimax/4
* Choose the best move for a player using the minmax algorithm.
* @1: +State - The state of the board
* @2: +Player - The current player
* @3: -BestMove - The best move to make
* @4: -Value - The value (fitness) associated with the best move
*/

minimax(FavPlayer, Board, _, _, Value, Depth) :-
  terminal(Board, FavPlayer, Value, Depth),
  !.

minimax(FavPlayer, Board, Player, BestMove, Value, Depth) :- 
  all_possible_plays(Player, Board, Moves),
  bestMove(FavPlayer, Board, Player, Moves, BestMove, Value, Depth).
  
/**
* bestMove/5
* Choose the best move between all possible move for a player.
* @1: +Player - The player who will play this move
* @2: +State - The board to consider
* @3: +Moves - The possible moves for player
* @4: -BestMove - The best move to make
* @5: -BestValue - The value (fitness) associated to the best move to make
*/
  
% No possible move
bestMove(FavPlayer, Board, Player, [], [], Value, Depth) :- 
  !,
  NewDepth is Depth - 1,
  
  reverse_pawn(Player, OtherPlayer),
  
  minimax(FavPlayer, Board, OtherPlayer, _, Value, NewDepth).

% One possible move
bestMove(FavPlayer, Board, Player, [[Row, Col]], [[Row, Col]], Value, Depth) :- 
  !,
  NewDepth is Depth - 1,
  
  flip_pawns(Board, Row, Col, Player, NewBoard),
  reverse_pawn(Player, OtherPlayer),
  
  minimax(FavPlayer, NewBoard, OtherPlayer, _, Value, NewDepth).

% General case
bestMove(FavPlayer, Board, Player, [[Row, Col]|OtherMoves], BestMove, BestValue, Depth) :-
  NewDepth is Depth - 1,
  
  flip_pawns(Board, Row, Col, Player, NewBoard),
  reverse_pawn(Player, OtherPlayer),
  
  minimax(FavPlayer, NewBoard, OtherPlayer, _, ValueFromFirst, NewDepth),
  bestMove(FavPlayer, Board, Player, OtherMoves, MoveFromTail, ValueFromTail, Depth),
  
  choose(FavPlayer, Player, [Row, Col], ValueFromFirst, MoveFromTail, ValueFromTail, BestMove, BestValue).
  
/**
* choose/6
* Choose the best move between two moves.
* @1: +Move1 - First move to compare
* @2: +Val1 - The value (fitness) associated to Move1
* @3: +Move2 - Second move to compare
* @4: +Val2 - The value (fitness) associated to Move2
* @5: -BestMove - The best move between both moves
* @6: -BestValue - The value associated with the best move
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
