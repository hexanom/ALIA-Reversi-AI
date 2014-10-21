/* Module Imports */
?- [ai/random].
?- [ai/minmax_score].
%?- [ai/minmax_positional].
%?- [ai/alphabeta_score].
%?- [ai/alphabeta_positional].

?- [ui/display].

/* Reversi settings */
% Choose your display
display(Board) :- console_display(Board).

%% Choose your White Player AI
ai_w(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).
% ai_w(Player, Board, Row, Col) :- minmax_score_ai(Player, Board, Row, Col).
% ai_w(Player, Board, Row, Col) :- alphabeta_score_ai(Player, Board, Row, Col).
% ai_w(Player, Board, Row, Col) :- minmax_positional_ai(Player, Board, Row, Col).
% ai_w(Player, Board, Row, Col) :- alphabeta_positional_ai(Player, Board, Row, Col).

%% Choose your Black Player AI
% ai_b(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).
ai_b(Player, Board, Row, Col) :- minmax_score_ai(Player, Board, Row, Col).
% ai_b(Player, Board, Row, Col) :-  alphabeta_score_ai(Player, Board, Row, Col).
% ai_b(Player, Board, Row, Col) :- minmax_positional_ai(Player, Board, Row, Col).
% ai_b(Player, Board, Row, Col) :-  alphabeta_positional_ai(Player, Board, Row, Col).

%% Used for positionnal heuristic
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