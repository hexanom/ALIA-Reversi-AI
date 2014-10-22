/* Module imports */
?- ['../engine/engine'].
?- ['positional'].
?- ['score'].

/**
 * count_moves/2
 * Counts the number of moves already played on the Board
 * @1: +Board - the  Board
 * @2: -NumberOfMoves - the number of moves already done
 */
count_moves([], 0).
count_moves(Board, NumberOfMoves) :-
	score(Board, e, Score),
	NumberOfMoves is 60 - Score. 
	
heuristic_score_and_positional_score(Board, Player, Score) :-
	count_moves(Board, NumberOfMoves),
	NumberOfMoves =< 40,
	heuristic_positional_score(Board, Player, Score).

heuristic_score_and_positional_score(Board, Player, Score) :-
	count_moves(Board, NumberOfMoves),
	NumberOfMoves > 40,
	heuristic_score(Board, Player, Score).
