/* Package imports */
?- ['../../engine/init'].
?- ['../../engine/model'].
?- ['../../engine/rules'].

?- admissible_plays(w, 2, 4).
?- admissible_plays(b, 4, 5).

?- board([
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w]
]).

?- is_finished(board).
