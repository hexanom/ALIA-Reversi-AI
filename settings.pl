/* Module Imports */
?- [ai/random].
?- [ai/heuristics/positional].
?- [ai/heuristics/score].
?- [ai/alphabeta].
?- [ai/minmax].

?- [ui/display].
?- [ui/display_gui].

/* Reversi settings */
% Choose your display
display(Board).
% display(Board) :- gui_display(Board).

%% Choose your White Player AI
% ai_w(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).
ai_w(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col, heuristic_score).

%% Choose your Black Player AI
% ai_b(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).

% ai_b(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col, heuristic_score).
ai_b(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col, heuristic_positional_score).
% ai_b(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col, heuristic_score_and_positional_score).

% ai_b(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col, heuristic_score).
% ai_b(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col, heuristic_positional_score).
% ai_b(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col, heuristic_score_and_positional_score).
