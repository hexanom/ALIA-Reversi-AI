/* Module Imports */
?- [ai/random].
?- [ui/display].

/* Reversi settings */
display(Board) :- console_display(Board).
ai_w(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).
ai_b(Player, Board, Row, Col) :- random_ai(Player, Board, Row, Col).
