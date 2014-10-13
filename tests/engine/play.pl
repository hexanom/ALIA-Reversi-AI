/* Package Imports */
?- ['../../engine/play'].

/* change_in_list/4 */
?- change_in_list(1, c, [a, b, c], [a, c, c]).

/* change_pawn/4 */
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

/* flip_in_dir/7 */
?- flip_in_dir([
  [e, e, e, e, e, e, e, e],
  [e, b, e, e, e, e, e, e],
  [e, e, b, e, e, e, e, e],
  [e, e, e, b, e, e, e, e],
  [e, e, e, e, b, e, e, e],
  [e, e, e, e, e, b, e, e],
  [e, e, e, e, e, e, w, e],
  [e, e, e, e, e, e, e, e]
], 0, 0, +1, +1, w, [
  [e, e, e, e, e, e, e, e],
  [e, w, e, e, e, e, e, e],
  [e, e, w, e, e, e, e, e],
  [e, e, e, w, e, e, e, e],
  [e, e, e, e, w, e, e, e],
  [e, e, e, e, e, w, e, e],
  [e, e, e, e, e, e, w, e],
  [e, e, e, e, e, e, e, e]
]).
?- flip_in_dir([
  [e, e, e, e, e, e, e, e],
  [e, b, e, e, e, e, e, e],
  [e, e, b, e, e, e, e, e],
  [e, e, e, b, e, e, e, e],
  [e, e, e, e, b, e, e, e],
  [e, e, e, e, e, b, e, e],
  [e, e, e, e, e, e, b, e],
  [e, e, e, e, e, e, e, w]
], 0, 0, +1, 0, w, [
  [e, e, e, e, e, e, e, e],
  [e, b, e, e, e, e, e, e],
  [e, e, b, e, e, e, e, e],
  [e, e, e, b, e, e, e, e],
  [e, e, e, e, b, e, e, e],
  [e, e, e, e, e, b, e, e],
  [e, e, e, e, e, e, b, e],
  [e, e, e, e, e, e, e, w]
]).
?- flip_in_dir([
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
], 7, 7, +1, +1, w, [
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e]
]).
?- flip_in_dir([
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, b, e, e, e],
  [e, e, e, e, e, b, e, e],
  [e, e, e, e, e, e, w, e],
  [e, e, e, e, e, e, e, e]
], 3, 3, +1, +1, w, [
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, e, e, e, e],
  [e, e, e, e, w, e, e, e],
  [e, e, e, e, e, w, e, e],
  [e, e, e, e, e, e, w, e],
  [e, e, e, e, e, e, e, e]
]).

/* flip_pawns/5 */
?- flip_pawns([
  [b, e, e, w, e, e, e, e],
  [e, b, e, b, e, e, e, e],
  [e, e, b, b, e, e, e, e],
  [w, b, b, e, b, b, b, e],
  [e, e, e, b, b, e, e, e],
  [e, e, e, b, e, b, e, e],
  [e, e, e, b, e, e, w, e],
  [e, e, e, b, e, e, e, e]
], 3, 3, w, [
  [b, e, e, w, e, e, e, e],
  [e, b, e, w, e, e, e, e],
  [e, e, b, w, e, e, e, e],
  [w, w, w, w, b, b, b, e],
  [e, e, e, b, w, e, e, e],
  [e, e, e, b, e, w, e, e],
  [e, e, e, b, e, e, w, e],
  [e, e, e, b, e, e, e, e]
]).
