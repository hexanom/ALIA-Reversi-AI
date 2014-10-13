/* count : helper pour determiner le nombre
 d'occurences d'un élement dans une liste */
count(E, [], 0).

count(E, [E|List], NbOccurs) :-
	count(E, List, Occurs),
	NbOccurs is Occurs + 1.

count(E, [X|List], Occurs) :-
	count(E, List, Occurs).
	
/* score : calcul du score d'un joueur  */
score([], Color, 0).

score([X|List], Color, Score) :-
	count(Color, X, NbOccurs),
	score(List, Color, ScoreReste),
	Score is NbOccurs + ScoreReste.
	
/* Aleatoire player NB : admissiblePlays unfinished !!*/
randomPlay(Player, Board, Row, Col) :- 
	all_possible_plays(Player, Board, AllPlays),
	random_member([Row, Col], AllPlays).


	/* all_possible_plays : tous les coups possible*/
all_possible_plays(Player, Board, AllPlays) :-
	findall([R, C], (admissible_plays(Player, Board, R, C)), AllPlays).
	

/* minimax*/

%  : 
% is_finished(+State) => Vrai si aucun joueur n'est en mesure de jouer un coup

/* moves(+State, +Player, -NewStates) : NewBoards correspond correspond à tous les états possibles du Bord après coups admissibles */
moves(State, Player, NewStates) :- 
	all_possible_plays(Player, State, AllPlays),
    make_plays(Player, State, AllPlays, NewStates).

/* make_plays : Joue tous les coups possibles et renvoie la liste des differents états du plateau */	
make_plays(Player, State, [], State).
	
make_plays(Player, State, [[PlayRow|PlayCol]|OtherPlays], [BoardRes|OtherNewStates]) :-
	change_pawn(State, PlayRow, PlayCol, Player, BoardRes),
	make_plays(Player, State, OtherPlays, OtherNewStates).
	

% terminal: le score de notre joueur
terminal(State, Value) :-
	is_finished(State),
	score(State, FavoritePlayer, X), 
	Value is X,
	!.

% minimax : cas de base = le jeu est fini
minimax(State, _, Value) :- 
	terminal(State, Value),
	!.
	
% minimax : 
minimax(State, BestMove, Value) :- 
	currentPlayer(State, Player),
	moves(State, Player, Moves),
	bestMove(Player, State, Moves, BestMove, Value).
	
% bestMove : Cas 1 = un seul mouvement est possible, alors on le fait
bestMove(_, State, [OneMove], OneMove, Value) :- 
	!,
	minimax(OneMove, _, Value).
	
% bestMove: cas 2 : il ne reste plus de mouvement possible
bestMove(_, State, [], State, Value) :- 
	!,
	minimax(State, _, Value).

% bestMove : cas général
bestMove(Player, State, [FirstMove|OtherMoves], BestMove, BestValue) :-
	minimax(FirstMove, _, ValueFromFirst),
	bestMove(Player, OtherMoves, MoveFromTail, ValueFromTail),
	choose(Player, FirstMove, ValueFromFirst, MoveFromTail, ValueFromTail, BestMove, BestValue).
	
% choose : choose between 2 solutions
choose(Player, Move1, Val1, Move2, Val2, Move1, Val1) :-
	Val1 >= Val2,
	Player=:=FavoritePlayer,
	!.
choose(Player, Move1, Val1, Move2, Val2, Move1, Val1) :-
	Val1 <= Val2,
	Player=/=FavoritePlayer,
	!.
choose(Player,_, _, Move2, Val2, Move2, Val2).
