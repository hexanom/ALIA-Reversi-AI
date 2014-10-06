/**
 * Relation: init_board/1
 * Unifies Board to the beginning of the game
 * @1: Board - the board in the initialized state
 */
init_board(Board) :- Board =
  [
    [e, e, e, e, e, e, e, e],
    [e, e, e, e, e, e, e, e],
    [e, e, e, e, e, e, e, e],
    [e, e, e, w, b, e, e, e],
    [e, e, e, b, w, e, e, e],
    [e, e, e, e, e, e, e, e],
    [e, e, e, e, e, e, e, e],
    [e, e, e, e, e, e, e, e]
  ].

/**
 * Relation: init_player/1
 * Unifies CurrentPlayer to the white (w) player
 * @1: CurrentPlayer - the player initialized
 */
init_player(CurrentPlayer) :- CurrentPlayer = w.

/**
 * Relation: init/2
 * Unifies Board and CurrentPlayer to the beginning of the game
 * @1: Board - the initialized board
 * @2: CurrentPlayer - the initialized player
 */
init(Board, CurrentPlayer) :-
  init_board(Board),
  init_player(Player).
