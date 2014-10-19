%% Each square on the board has a different value that we use to compute the IA's score
marks([
	[500,-150,30,10,10,30,-150,500],
	[-150,-250,0,0,0,0,-250,-150],
	[30,0,1,2,2,1,0,30],
	[10,0,2,16,16,2,0,10],
	[10,0,2,16,16,2,0,10],
	[30,0,1,2,2,1,0,30],
	[-150,-250,0,0,0,0,-250,-150],
	[500,-150,30,10,10,30,-150,500]
]).

score_square(Case, ValeurCase, Player, ValeurCase) :-
	Player == Case.
	
score_square(Case, _, Player, 0) :-
	Player \== Case.
	
square_value(Marks, LigneIndex, CaseIndex, ValeurCase) :-
	nth0(LigneIndex, Marks, Ligne),
	nth0(CaseIndex, Ligne, ValeurCase).
	
score_line(_, [], _, _, _, 0).
score_line(Marks, [Case|AutresCases], LigneIndex, CaseIndex, Player, LigneScore) :-
	NewCaseIndex is CaseIndex + 1,
	score_line(Marks, AutresCases, LigneIndex, NewCaseIndex, Player, TailLigneScore),
	square_value(Marks, LigneIndex, CaseIndex, ValeurCase),
	score_square(Case, ValeurCase, Player, ScoreCase),
	LigneScore is ScoreCase + TailLigneScore.
	
score_board(_, [], _, _, 0).
score_board(Marks, [Ligne|AutresLignes], LigneIndex, Player, Score) :-
	NewIndex is LigneIndex + 1,
	score_board(Marks, AutresLignes, NewIndex, Player, TailScore),
	score_line(Marks, Ligne, LigneIndex, 0, Player, ListeScore),
	Score is ListeScore + TailScore.
	
heuristic_positional_score(Board, Player, Score) :-
	marks(Marks),
	score_board(Marks, Board, 0, Player, Score).
