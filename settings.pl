/* Module Imports */
?- [ai/random].
%?- [ai/minmax_score].
?- [ai/alphabeta_score].

?- [ui/display].

/* Reversi settings */
% Choose your display
display(Board) :- console_display(Board).

%% Choose your White Player AI
ai_w(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).
% ai_w(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col).
% ai_w(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col).

%% Choose your Black Player AI
% ai_b(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).
% ai_b(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col).
ai_b(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col).
