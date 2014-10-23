?- ['../engine/model'].
?- ['../engine/rules'].

/*création de la fenêtre (variable globale)*/
init_image :-
  pce_global(@p, new(dialog('Othello'))),
  send(@p,size,size(400,500)),
  send(@p, open),
  send(@p, append, new(B,button(quit, message(@p, destroy)))),
  send(@p, display, B,point(163,440)),
  send(@p, open).

display_players :-
  new(T1, text('White:')),
  send(@p, display, T1, point(40,420)),
  new(T2, text(': Black')),
  send(@p, display, T2, point(320, 420)).

display_score(Score,1) :-
  send(@p, display,new(B1, box(42,17)),point(93,420)),
  send(B1, fill_pattern, colour(darkgreen)),
  send(@p, display,new(B2, box(40,15)),point(93,420)),
  send(B2, fill_pattern, colour(white)),
  new(T3, text(Score)),
  send(@p, display, T3, point(100, 420)).

  display_score(Score,2) :-
  send(@p, display,new(B3, box(42,17)),point(293,420)),
  send(B3, fill_pattern, colour(darkgreen)),
  send(@p, display,new(B4, box(40,15)),point(293,420)),
  send(B4, fill_pattern, colour(white)),
  new(T4, text(Score)),
  send(@p, display, T4, point(300, 420)).

afficher(w,X,Y,@p):-
  send(@p, display, new(C, circle(50)), point(50*X,50*Y)),
  send(C, fill_pattern, colour(white)).
afficher(b,X,Y,@p):-
  send(@p, display, new(R, circle(50)), point(50*X,50*Y)),
  send(R, fill_pattern, colour(black)).
afficher(e,_,_,@p).

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


gui_display(Board) :-
  init_image,
  display_board(@p),
  display_pawns(Board),
  display_players,
  score(Board, w, ScoreW),
  score(Board, b, ScoreB),
  display_score(ScoreW,1),
  display_score(ScoreB,2),
  sleep(0.5).
