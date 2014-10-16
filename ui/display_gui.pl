


/*création de la fenêtre (variable globale)*/
init_image :-
pce_global(@p, new(dialog('Othello'))),
send(@p,size,size(400,500)),
send(@p, open),
send(@p, append, new(B,button(quit, message(@p, destroy)))),
send(@p, display, B,point(163,440)),
send(@p, open).

display_players :- 
new(T1, text('player_1 :')),
send(@p, display, T1, point(40,420)),
new(T2, text(': player_2')),
send(@p, display, T2, point(320, 420)).

display_score(Score,1) :-
new(T3, text(Score)),
send(@p, display, T3, point(100, 420)).
display_score(Score,2) :-
new(T4, text(Score)),
send(@p, display, T4, point(300, 420)).


pawn(Board, Row, Col, Type) :-
nth0(Row, Board, List),
nth0(Col, List, Type).

/* Board à envoyer en paramètre (inversion ligne-colonne par rapport à l'afichage 
Board =
[
[e, e, e, e, w, e, e, e],
[e, e, e, e, e, e, b, e],
[e, e, e, e, e, e, e, e],
[e, e, e, w, b, e, e, e],
[e, w, e, b, w, e, e, e],
[e, e, e, e, e, e, e, e],
[e, e, e, e, e, e, e, e],
[e, e, e, e, b, e, e, e]
].*/
afficher(w,X,Y,@p):- send(@p, display, new(C, circle(50)), point(50*X,50*Y)),
send(C, fill_pattern, colour(white)).
afficher(b,X,Y,@p):- 
send(@p, display, new(R, circle(50)), point(50*X,50*Y)),
send(R, fill_pattern, colour(black)).
afficher(e,X,Y,@p).

/*création de la grille.*/
display_board(@p) :-
forall((between(0,7,X),
between(0,7,Y)),
(send(@p, display,new(Z, box(50,50)),point(50*X,50*Y)),
send(Z, fill_pattern, colour(darkgreen)))).


/*Récupération des pions dans la board*/
display_pawns(Board) :-
forall((between(0,7,X),
between(0,7,Y),
pawn(Board,X,Y,P)),
afficher(P,X,Y,@p)).

gui_display(Board,Score_1,Score_2) :-
init_image,
display_board(@p),
display_pawns(Board),
display_players,
display_score(Score_1,1),
display_score(Score_2,2).
