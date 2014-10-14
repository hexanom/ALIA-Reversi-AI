


/*création de la fenêtre (variable globale)*/
image :-
pce_global(@p, new(picture('Othello'))),
send(@p, open).



pawn(Board, Row, Col, Type) :-
nth0(Row, Board, List),
nth0(Col, List, Type).

/* Board à envoyer en paramètre (inversion ligne-colonne par rapport à l'afichage */
board(Board) :- Board =
[
[e, e, e, e, w, e, e, e],
[e, e, e, e, e, e, b, e],
[e, e, e, e, e, e, e, e],
[e, e, e, w, b, e, e, e],
[e, w, e, b, w, e, e, e],
[e, e, e, e, e, e, e, e],
[e, e, e, e, e, e, e, e],
[e, e, e, e, b, e, e, e]
].
/*création des pions.*/
afficher(w,X,Y,@p):- send(@p, display, new(C, circle(25)), point(25*X,25*Y)),
send(C, fill_pattern, colour(white)).
afficher(b,X,Y,@p):- send(@p, display, new(R, circle(25)), point(25*X,25*Y)),
send(R, fill_pattern, colour(black)).


/*création de la grille.*/
display_board(@p) :-
between(0,7,X),
between(0,7,Y),
send(@p, display,new(Z, box(25,25)),point(25*X,25*Y)),
send(Z, fill_pattern, colour(green)).


/*Récupération des pions dans la board*/
display_pawns :-
board(Board),
between(0,7,X),
between(0,7,Y),
pawn(Board,X,Y,P), afficher(P,X,Y,@p).

run :-
image,
display_board(@p),
display_pawns.
