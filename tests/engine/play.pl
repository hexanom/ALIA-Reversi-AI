/* Package Imports */
?- ['../../engine/play'].
?- ['../../engine/init'].

?- copy_list([a, b, c], [a, b, c]).
?- change_in_list(1, c, [a, b, c], [a, c, c]).
?- change_pawn([
  [e, e, e],
  [e, e, e],
  [e, e, e]
], 1, 1, w, [
  [e, e, e],
  [e, w, e],
  [e, e, e]
]).
?- change_pawn([
  [e, e, e],
  [e, e, e],
  [e, e, e]
], 0, 0, b, [
  [b, e, e],
  [e, e, e],
  [e, e, e]
]).

?- play_pawn(1, 1).
?- board([
  [e, e, e, e, e, e, e, e],
  [e, w, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, w, b, e, e, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
]).
?- current_player(b).
?- play_pawn(0, 0).
?- board([
  [b, e, e, e, e, e, e, e],
  [e, w, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, w, b, e, e, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
]).
?- current_player(w).
