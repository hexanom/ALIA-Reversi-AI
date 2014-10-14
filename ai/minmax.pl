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
  minimax(Board, Player, [Row, Col], _, 3).

/**
* moves/3
* Returns all boards states after playing every possible plays for a specific player
* @1: +State - The board to make the plays against
* @2: +Player - The player making the plays
* @3: -NewStates - All the board states after all the possible plays were made
*/
moves(State, Player, NewStates) :- 
  all_possible_plays(Player, State, AllPlays),
  make_plays(Player, State, AllPlays, NewStates).

/**
* make_plays/4
* Returns all boards states after playing every play against a single state
* @1: +Player - The player making the plays
* @2: +State - The board to make the plays against
* @3: +AllPlays - All the plays to make.
* @4: -AllBoards - All the board states after the plays were made.
*/
make_plays(Player, State, [], []).
  
make_plays(Player, State, [[PlayRow|[PlayCol]]|OtherPlays], [BoardRes|OtherNewStates]) :-
  flip_pawns(State, PlayRow, PlayCol, Player, BoardRes),
  make_plays(Player, State, OtherPlays, OtherNewStates).
  
/**
* terminal/3
* Succeeds when the game is over and returns the score of the IA's player.
* @1: +State - The state of the board
* @2: +Player - The currrent player
* @3: -Value - The value associated to this game.
*/
terminal(State, Player, Value, Depth) :-
  is_finished(State),
  score(State, Player, Value), 
  !.

terminal(State, Player, Value, Depth) :-
  Depth =:= 0, 
  score(State, Player, Value), 
  !.

/**
* minimax/4
* Choose the best move for a player using the minmax algorithm.
* @1: +State - The state of the board
* @2: +Player - The current player
* @3: -BestMove - The best move to make
* @4: -Value - The value (fitness) associated with the best move
*/

minimax(State, Player, _, Value, Depth) :- 
  terminal(State, Player, Value, Depth),
  !.

minimax(State, Player, BestMove, Value, Depth) :- 
  moves(State, Player, Moves),
  bestMove(Player, State, Moves, BestMove, Value, Depth).
  
/**
* bestMove/5
* Choose the best move between all possible move for a player.
* @1: +Player - The player who will play this move
* @2: +State - The board to consider
* @3: +Moves - The possible moves for player
* @4: -BestMove - The best move to make
* @5: -BestValue - The value (fitness) associated to the best move to make
*/

% One possible move
bestMove(Player, State, [OneMove], OneMove, Value, Depth) :- 
  !,
  reverse_pawn(Player, OtherPlayer),
  NewDepth is Depth - 1.
  minimax(OtherPlayer, OneMove, _, Value, NewDepth).
  
% No possible move
bestMove(Player, State, [], State, Value, Depth) :- 
  !,
  reverse_pawn(Player, OtherPlayer),
  NewDepth is Depth - 1.
  minimax(OtherPlayer, State, _, Value, NewDepth).

% General case
bestMove(Player, State, [FirstMove|OtherMoves], BestMove, BestValue, Depth) :-
  reverse_pawn(Player, OtherPlayer),
  NewDepth is Depth - 1,
  minimax(FirstMove, OtherPlayer, _, ValueFromFirst, NewDepth),
  bestMove(Player, State, OtherMoves, MoveFromTail, ValueFromTail, Depth),
  choose(FirstMove, ValueFromFirst, MoveFromTail, ValueFromTail, BestMove, BestValue).
  
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
choose(Move1, Val1, Move2, Val2, Move1, Val1) :-
  Val1 >= Val2,
  !.
choose(_, _, Move2, Val2, Move2, Val2).
