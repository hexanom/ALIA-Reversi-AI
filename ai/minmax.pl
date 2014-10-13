/* Module imports */
?- ['../engine/engine'].

% TODO: PLEASE DO SOMETHING COMPLIANT TO THE random_ai INTERFACE
% TODO: INDENT 2 SOFT TABS !!! (edourd, regle ton vim ! )

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

