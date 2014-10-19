/* Module imports */
?- ['../../engine/rules'].

heuristic_score(Board, Player, Value) :-
  score(Board, Player, Value).

