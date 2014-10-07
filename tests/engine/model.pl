/* Package imports */
?- ['../engine/init'].
?- ['../engine/model'].

/* is_inbound/2 */
?- is_inbound(1, 1).
?- not(is_inbound(-1, -1)).
?- not(is_inbound(8, 8)).

/* pawn/3 */
?- pawn(0, 0, e).
?- pawn(3, 3, w).
?- not(pawn(-1, 3, e)).
?- not(pawn(4, 3, w)).

/* reverse_pawn/3 */
?- reverse_pawn(w, b).
?- not(reverse_pawn(w, w)).
