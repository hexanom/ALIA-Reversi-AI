/* Module Imports */
?- [ai/random].
?- [ai/heuristics/positional].
?- [ai/heuristics/score].
?- [ai/heuristics/score_and_positional].
?- [ai/alphabeta].
?- [ai/minmax].
?- [ai/human].

?- [ui/display].
?- [ui/display_gui].

/* Reversi settings */
% Choose your display
% display(Board). % Headless
% display(Board) :- console_display(Board).
display(Board) :- gui_display(Board).

%% Choose your White Player AI
ai_w(_, _, Row, Col) :- human(_, _, Row, Col).
% ai_w(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).
% ai_w(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col, heuristic_positional_score).
ai_w(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col, heuristic_score).

%% Choose your Black Player AI
% ai_b(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).

% ai_b(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col, heuristic_score).
ai_b(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col, heuristic_positional_score).
% ai_b(Player, Board, Row, Col) :- alphabeta_ai(Player, Board, Row, Col, heuristic_combination_score_and_positional).

% ai_b(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col, heuristic_score).
% ai_b(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col, heuristic_positional_score).
% ai_b(Player, Board, Row, Col) :- minmax_ai(Player, Board, Row, Col, heuristic_combination_score_and_positional).
