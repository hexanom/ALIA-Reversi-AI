/* Module imports */
?- ['../engine/engine'].
?- ['positional'].
?- ['score'].

% Combination of score and positional heuristics
% For the first 40 moves positional heuristic is used
% And for the last ones, score heuristic is chosen

/**
 * count_moves/2
 * Counts the number of moves already played on the Board
 * @1: +Board - the  Board
 * @2: -NumberOfMoves - the number of moves already done
 */
count_moves([], 0).
count_moves(Board, NumberOfMoves) :-
	score(Board, e, EmptySquares),
	NumberOfMoves is 60 - EmptySquares,
	!.

heuristic_combination_score_and_positional(Board, Player, Score) :-
	count_moves(Board, NumberOfMoves),
	NumberOfMoves =< 50,
	heuristic_positional_score(Board, Player, Score),
	!.

heuristic_combination_score_and_positional(Board, Player, Score) :-
	count_moves(Board, NumberOfMoves),
	NumberOfMoves > 50,
	heuristic_score(Board, Player, Score),
	!.
