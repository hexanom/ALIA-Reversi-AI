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
	
positional_score(Marks, Board, Player, Score) :-
	score_board(Marks, Board, 0, Player, Score).