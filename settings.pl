/* Module Imports */
?- [ai/random].
%?- [ai/minmax_score].
%?- [ai/alphabeta_score].
%?- [ai/minmax_positional].
?- [ai/alphabeta_positional].

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
% ai_b(Player, Board, Row, Col) :- minmax_score_ai(Player, Board, Row, Col).
% ai_b(Player, Board, Row, Col) :- alphabeta_score_ai(Player, Board, Row, Col).
% ai_b(Player, Board, Row, Col) :- minmax_positional_ai(Player, Board, Row, Col).
ai_b(Player, Board, Row, Col) :- alphabeta_positional_ai(Player, Board, Row, Col).
