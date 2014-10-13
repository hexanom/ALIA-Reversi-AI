/* Module imports */
?- ['../engine/engine'].

/**
 * random_ai/4
 * Play randomly
 * @1: +Player - the player running the ai
 * @2: +Board - the board to play on
 * @3: -Row - the row where random will play
 * @4: -Col - the column where random will play
 */
random_ai(Player, Board, Row, Col) :-
  all_possible_plays(Player, Board, AllPlays),
  random_member([Row, Col], AllPlays).
