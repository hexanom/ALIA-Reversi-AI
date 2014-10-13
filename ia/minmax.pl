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
	
/* minimax*/

% moves(+State, +Player, -NewStates) : NewBoards correspond correspond à tous les états possibles du Bord après coups admissibles
% is_finished(+State) => Vrai si aucun joueur n'est en mesure de jouer un coup

% Cas 1 : le score de player  
terminal(State, Value) :-
	score(State, FavoritePlayer, X), 
	Value is X,
	is_finished(State),
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


	