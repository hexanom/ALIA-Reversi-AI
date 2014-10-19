/* Module Imports */
?- [engine/engine].
?- [settings].

/**
 * game_loop/2
 * Defines the main game loop (check the output for results)
 * @1: +Board - the inital board
 * @2: +Plaer - the starting player (w or b)
 */
game_loop(Board, w) :- % Not finished, w's turn
  not(is_finished(Board)),
  admissible_plays(w, Board, _, _),
  display(Board),
  writeln('White is playing…'),
  ai_w(w, Board, Row, Col),
  flip_pawns(Board, Row, Col, w, NewBoard),
  game_loop(NewBoard, b).
game_loop(Board, b) :- % Not finished, b's turn
  not(is_finished(Board)),
  admissible_plays(b, Board, _, _),
  display(Board),
  writeln('Black is playing…'),
  ai_b(b, Board, Row, Col),
  flip_pawns(Board, Row, Col, b, NewBoard),
  game_loop(NewBoard, w).
game_loop(Board, CurrentPlayer) :- % Not finished, one player is stuck
  not(is_finished(Board)),
  not(admissible_plays(CurrentPlayer, Board, _, _)),
  reverse_pawn(CurrentPlayer, NextPlayer),
  game_loop(Board, NextPlayer).
game_loop(Board, _) :- % Game finished, score time !
  is_finished(Board),
  score(Board, w, WhiteScore),
  score(Board, b, BlackScore),
  display(Board),
  writeln(''),
  writeln('Scores:'),
  writeln('-------'),
  write('White: '),
  write(WhiteScore),
  writeln(''),
  write('Black: '),
  write(BlackScore).

% Start the loop !
?- game_loop([
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, w, b, e, e, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
], b).
