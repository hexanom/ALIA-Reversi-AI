/* Module Imports */
?- [ai/random].
?- [ai/heuristics/positional].
?- [ai/heuristics/score].
?- [ai/alphabeta].
?- [ai/minmax].

?- [ui/display].

/* Reversi settings */
% Choose your display
display(Board) :- console_display(Board).

%% Choose your White Player AI
ai_w(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).

%% Choose your Black Player AI
% ai_b(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).
% ai_b(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col, heuristic_score).
ai_b(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col, heuristic_positional_score).
% ai_b(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col, heuristic_score).
% ai_b(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col, heuristic_positional_score).
