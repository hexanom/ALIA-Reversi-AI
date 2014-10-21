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


score_square(Square, SquareValue, Player, SquareValue) :-
	Player == Square.
	
score_square(Square, _, Player, 0) :-
	Player \== Square.
	
square_value(Marks, IndexLine, SquareIndex, SquareValue) :-
	nth0(IndexLine, Marks, Line),
	nth0(SquareIndex, Line, SquareValue).
	
score_line(_, [], _, _, _, 0).
score_line(Marks, [Square|OtherSquares], IndexLine, SquareIndex, Player, ScoreLine) :-
	NewSquareIndex is SquareIndex + 1,
	score_line(Marks, OtherSquares, IndexLine, NewSquareIndex, Player, TailScoreLine),
	square_value(Marks, IndexLine, SquareIndex, SquareValue),
	score_square(Square, SquareValue, Player, SquareScore),
	ScoreLine is SquareScore + TailScoreLine.
	
score_board(_, [], _, _, 0).
score_board(Marks, [Line|OtherLines], IndexLine, Player, Score) :-
	NewIndex is IndexLine + 1,
	score_board(Marks, OtherLines, NewIndex, Player, TailScore),
	score_line(Marks, Line, IndexLine, 0, Player, ListScore),
	Score is ListScore + TailScore.
	
heuristic_positional_score(Board, Player, Score) :-
	marks(Marks),
	score_board(Marks, Board, 0, Player, Score).
