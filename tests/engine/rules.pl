/* Package imports */
?- ['../../engine/init'].
?- ['../../engine/model'].
?- ['../../engine/rules'].

?- admissible_plays(w, [
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, w, b, e, e, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
], 2, 4).
?- admissible_plays(b, [
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, w, b, e, e, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
], 4, 5).
?- not(admissible_plays(b, [
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, w, b, e, e, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
], 2, 2)).
?- not(admissible_plays(b, [
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, w, b, e, e, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
], 3, 3)).
?- admissible_plays(b, [
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, w, b, e, e, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, e, e, b, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
], 2, 2).
