/* Package imports */
?- ['../../engine/rules'].

/* admissible_plays/4 */
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

/* is_finished/1 */
?- is_finished([
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w]
]).
?- not(is_finished([
  [b, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, w],
  [w, w, w, w, w, w, w, e]
])).

/* all_possible_plays/3 */
?- all_possible_plays(w, [
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, w, b, e, e, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
], [[5, 3], [3, 5], [2, 4], [4, 2]]).

/* count/3 */
?- count(a, [a, a, a], 3).
?- count(a, [b, a, a], 2).

/* score/3 */
?- score([
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, w, b, e, e, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
], w, 2).
